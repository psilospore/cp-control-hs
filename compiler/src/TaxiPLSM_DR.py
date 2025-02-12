import PrismAST as PAST
import LoopingStateMachine as PLSM
import BayesianModel as BM
import ConfMatModel as CMM
# import CorrErrModel as CEM
import ShieldBuilder as SB
import ComponentMinimizer as CM
from PrismComponent import PrismComponent
import PrismComponent as PC

from functools import reduce

# Includes dead reckoning in controller and dynamics of TaxiNet Prism LoopingStateMachine

## Controller


def control_func(m,args):
    cte_ests=[args[i][1] for i in range(m)]
    he_ests=[args[m+i][1] for i in range(m)]

    
    actions=[]
    for state in zip(cte_ests,he_ests):
        actions.append(SB.find_safe_actions(state))
        
    safe_actions = set(actions[0])
    for sas in actions:
        safe_actions.union(sas)

    cte_est=cte_ests[0]
    he_est=he_ests[0]
    if cte_est==0:
            prefered_a=-he_est
    else:
        cte_sign = int(cte_est / abs(cte_est))
        if cte_sign*he_est == -1:
            prefered_a=0
        else:
            prefered_a=-cte_sign

    if not safe_actions or prefered_a in safe_actions:
        # print("rejecting prefered")
        final_a=prefered_a
    else:
        final_a=safe_actions.pop()
        
    return [(f"(a'={final_a})",1)]

def control(state_est,*_):
    m=len(state_est)//2
    return lambda pc : PC.define_component_by_enumeration(state_est,lambda args: control_func(m,args),pc)

def min_control(state_est,action,_):
    return lambda pc : list(map(lambda x: x.addPC(pc),CM.minimize_component(state_est,action,SB.controller)))

## Dynamics

def dynamics(_,__,fail_states):
    def dynamic_func(pc):
        return [PAST.PrismTrans(f"cte>=-2 & cte<=2 & he>=-1 & he<=1 & pc={pc}",[(f"(he'=he+a) & (cte'=cte+he+a) & (pc'={pc+1})",1)]),
                PAST.PrismTrans(f"(cte< -2 | cte>2 | he< -1 | he>1) & pc={pc}",[(f"(pc'={fail_states[0]})",1)])]
    return dynamic_func

## Aborter

def aborter(state,_,fail_states):
    # should use enum_low and enum_high rather than hardcoding  
    return lambda pc : [
        PAST.PrismTrans(f"(cte< -2 | cte>2) & pc={pc}",[(f"(pc'={fail_states[0]})",1)]),
        PAST.PrismTrans(f"(he< -1 | he>1) & pc={pc}",[(f"(pc'={fail_states[1]})",1)]),
        PAST.PrismTrans(f"cte>=-2 & cte<=2 & he>=-1 & he<=1 & pc={pc}",[(f"(pc'={pc+1})",1)])
    ]


## Dead Reckoning
    
def dead_reckoning(state_est,_,fail_states):
    m=len(state_est)//2
    assert m>=2
    land =lambda x,y: x+" & "+y
    lor =lambda x,y: x+" | "+y

    dr_cond = [f"cte_est{i-1}>=-2 & cte_est{i-1}<=2 & he_est{i-1}>=-1 & he_est{i-1}<=1" for i in range(1,m)]
    dr_cond_sum = reduce(land, dr_cond[1:], dr_cond[0])
    
    dr_dyn = [f"(he_est{i}'=he_est{i-1}+a) & (cte_est{i}'=cte_est{i-1}+he_est{i-1}+a)" for i in range(1,m)]
    dr_dyn_sum = reduce(land, dr_dyn[1:], dr_dyn[0])

    dr_fail_cond = [f"cte_est{i}< -2 | cte_est{i}>2 | he_est{i}< -1 | he_est{i}>1" for i in range(0,m-1)]
    dr_fail_cond_sum = reduce(lor,dr_fail_cond[1:],dr_fail_cond[0])
    
    return lambda pc : [PAST.PrismTrans(dr_cond_sum+f" & pc={pc}",[(dr_dyn_sum+f" & (pc'={pc+1})",1)]),
                        PAST.PrismTrans(f"({dr_fail_cond_sum}) & pc={pc}",[(f"(pc'={fail_states[0]})",1)])]


## Create Model

def create_TaxiPLSM_DR(label,cte_sample_file,he_sample_file,m=3):
    cte = PAST.PrismVar("cte",-4,4,0,enum_low=-2,enum_high=2)
    he = PAST.PrismVar("he",-2,2,0,enum_low=-1,enum_high=1)
    cte_ests=[]
    he_ests=[]
    for i in range(m):
        cte_ests.append(PAST.PrismVar(f"cte_est{i}",-4,4,0,enum_low=-2,enum_high=2))
        he_ests.append(PAST.PrismVar(f"he_est{i}",-2,2,0,enum_low=-1,enum_high=1))
        
    a = PAST.PrismVar("a",-1,1,0)
    variables=[cte,he,a]+cte_ests+he_ests
    
    cte_model = CMM.ConfusionMatrix(cte_sample_file)
    he_model = CMM.ConfusionMatrix(he_sample_file)

    state=["cte","he"]
    state_est=[f"cte_est{i}" for i in range(m)] + [f"he_est{i}" for i in range(m)]
    action=["a"]
    fail_states=["cte_fail","he_fail","dyn_fail","dr_fail"]
    
    taxiP_cte = PrismComponent("Perceiver (CTE)",["cte"],["cte_est0"],[],cte_model.perceiver_from_est_model())
    taxiP_he = PrismComponent("Perceiver (HE)",["he"],["he_est0"],[],he_model.perceiver_from_est_model())
    taxiC = PrismComponent("Controller",state_est,action,[],min_control)
    taxiD = PrismComponent("Dynamics",state+action,state,["dyn_fail"],dynamics)
    taxiA = PrismComponent("Aborter",state,[],fail_states[:2],aborter)
    taxiDR = PrismComponent("Dead Reckoning",state_est,state_est,["dr_fail"],dead_reckoning)

    components=[taxiP_cte,taxiP_he,taxiD,taxiDR,taxiA,taxiC]
    

    return PLSM.PrismLoopingStateMachine("TaxiDR",label,components,variables,fail_states)


import argparse

def main():
    parser = argparse.ArgumentParser(description="CLI for producing Dead Reckoning Model.")

    parser.add_argument("--cte", required=True, type=str, help="Filename of cte sample")
    parser.add_argument("--he", required=True, type=str, help="Filename of he sample")
    parser.add_argument("--label", "-l", required=True, type=str, help="Instance label, used to differentiate models with distinct data")
    parser.add_argument("--m", "-m", required=True, type=int, help="Lookback for Dead Reckoning model")
    

    # Parse arguments
    args = parser.parse_args()



    plsm = create_TaxiPLSM_DR(args.label,args.cte,args.he,m=args.m)
    print(f"writing to {plsm.filename}")
    plsm.save_to_file()

if __name__=="__main__":
    main()
