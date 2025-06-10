# Converts CSV from tempest output to shield
# assumes woven encoding (-2,-1,0,1,2) -> (4,2,0,1,3)
import argparse
import csv

import ComponentMinimizer as CM
import PrismAST as PAST
import PrismComponent as PC
import DataLoader as DL
from Util import *

# Action : Int [0,2]
# CteEst : Int [0,4]
# HeEst : Int [0,2]
# StateEst : (CteEst,HeEst)
# Prob : Float [0,1]
# Shield : (StateEst -> [Action])
# TempestModel :  [(cte_est : CteEst, he_est : HeEst, action0 : Prob, action1 : Prob, action2 : Prob)]
# TempestModelDict : {(CteEst,HeEst) -> (0:Prob,1:Prob,2:Prob)}


# TempestModel -> TempestModelDict
def tempest_model_to_dict(tempest_model):
    return {(int(cte_est),int(he_est)) : ((0,float(action0)),(1,float(action1)),(2,float(action2))) for cte_est,he_est,action0,action1,action2 in tempest_model}

# (TempestModelDict,(Action,Prob) -> Bool) -> Shield 
def tempest_model_to_shield(tempest_model_dict,filter_func):

    # filter for only shielded actions using probability via filter_func
    # strip probability and only return action set
    def shield(cte_est,he_est):
        return set(map(lambda x: x[0],filter(filter_func,tempest_model_dict[(cte_est,he_est)])))

    return shield


# Shield -
def shield_to_control_func(shield):

    def controller(var_assign):
        # k=len(var_assign)//2
        # decode one hot encoding into obs lists
        cte_ests=[i for i in range(5) if var_assign[i][1]==1 ]
        he_ests=[i for i in range(3) if var_assign[i+5][1]==1 ]
        all_pairs = [(cte_est,he_est) for cte_est in cte_ests for he_est in he_ests]
        # print("all pairs",all_pairs)
        
        # no estimated states
        # this occurs if *either* he or cte are estimated empty
        if len(all_pairs)==0:
            return ["(default'=2)"] # [PAST.PrismAssign("a",i,lhs=False) for i in range(0,3)] 
        
        # print(var_assign)
        # print(cte_ests,he_ests)
        
        safe_actions = inner_reduce(lambda x,y : x.intersection(y),
                                    [shield(*state) for state in all_pairs])
        
        
        # print("safe actions", safe_actions)
        if not safe_actions:
            # no safe actions
            return ["(default'=1)"] # triggers default control
        else:
            return [PAST.PrismAssign("a",a,lhs=False) for a in safe_actions]
        
    return controller
    
def tempest_shielded_controller(tempest_file,filter_func,minimize=False):

    tempest_model_dict = tempest_model_to_dict(DL.read_csv_to_tuples(tempest_file,skip_header=True))
    # print(tempest_model_dict)
    control_func = shield_to_control_func(tempest_model_to_shield(tempest_model_dict,filter_func))

    if not minimize:
        def control(state_est,action,fail_states):
            # print(mapL(str,state_est))
            return lambda pc : PC.define_component_by_enumeration_ND(state_est,control_func,pc)
        return control
    else:
        def min_control(state_est,action,_):
            # print(state_est[0],state_est[1])
            return lambda pc : list(map(lambda x:x.addPC(pc),CM.minimize_component(state_est,action,control_func)))
        return min_control


    
if __name__=="__main__":
    parser = argparse.ArgumentParser(description="CLI for generating Shield components from tempest")

    parser.add_argument("--tempest_file","-tf",required=True,type=str)
    parser.add_argument("--action_filter","-af",required=True,type=float)
    parser.add_argument("--pc","-pc",required=True,type=int)
    parser.add_argument('--minimize', action=argparse.BooleanOptionalAction)

    
    args=parser.parse_args()


    # mimics component and Prism generation from LoopingStateMachine

    # these don't matter
    state_est=["cte_est","he_est"]
    action=["action"]
    cte_high=4
    he_high=2
    cte_est_vars=[PAST.PrismVar(f"cte_est{i}",0,1,0) for i in range(cte_high+1)]
    he_est_vars=[PAST.PrismVar(f"he_est{i}",0,1,0) for i in range(he_high+1)]

    a = PAST.PrismVar("a",0,2,0)

    tsc = tempest_shielded_controller(args.tempest_file,lambda a_p : a_p[1]>args.action_filter,minimize=args.minimize)

    component = PC.PrismComponent("Controller",state_est,action,[],tsc)
    
    toPrismLines = lambda x : x.toPrismLines()
    pl = composeLines("",mapL(lambda line : composeLines("",line),mapL(toPrismLines,component.logic(cte_est_vars+he_est_vars,[a],[])(args.pc))))
    
    print(pl)
    
        
# so far, works with: `python src/TempestToShieldedController.py -tf lib/tempest_test -af 0.2 -pc 0`
