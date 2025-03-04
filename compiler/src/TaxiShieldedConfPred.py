import argparse

import PrismComponent as PC
import LoopingStateMachine as PLSM
import PrismAST as PAST
import TempestToShieldedController as TSC
from Util import *
# import DataLoader as DL


def dynamics_logic(state_action,state,fail_states):
    def dynamics_lines(pc):
        lines = f'''
[] he=1 & a=1 & pc={pc} -> 1 : (he'=-1) & (pc'={fail_states[0]}); // error
[] he=2 & a=2 & pc={pc} -> 1 : (he'=-1) & (pc'={fail_states[0]}); // error
[] cte=0 & he=0 & a=0 & pc={pc} -> 1 : (pc'={pc+1});
[] cte=0 & he=0 & a=1 & pc={pc} -> 1 : (cte'=1) & (he'=1) & (pc'={pc+1});
[] cte=0 & he=0 & a=2 & pc={pc} -> 1 : (cte'=2) & (he'=2) & (pc'={pc+1});
[] cte=0 & he=1 & a=0 & pc={pc} -> 1 : (cte'=1) & (pc'={pc+1});
[] cte=0 & he=1 & a=2 & pc={pc} -> 1 : (he'=0) & (pc'={pc+1});
[] cte=0 & he=2 & a=0 & pc={pc} -> 1 : (cte'=2) & (pc'={pc+1});
[] cte=0 & he=2 & a=1 & pc={pc} -> 1 : (he'=0) & (pc'={pc+1});
// left -side dynamics:
[] cte=1 & he=0 & a=0 & pc={pc} -> 1 : (pc'={pc+1});
[] cte=1 & he=0 & a=1 & pc={pc} -> 1 : (cte'=3) & (he'=1) & (pc'={pc+1});
[] cte=1 & he=0 & a=2 & pc={pc} -> 1 : (cte'=0) & (he'=2) & (pc'={pc+1});
[] cte=1 & he=1 & a=0 & pc={pc} -> 1 : (cte'=3) & (pc'={pc+1});
[] cte=1 & he=1 & a=2 & pc={pc} -> 1 : (he'=0) & (pc'={pc+1});
[] cte=1 & he=2 & a=0 & pc={pc} -> 1 : (cte'=0) & (pc'={pc+1});
[] cte=1 & he=2 & a=1 & pc={pc} -> 1 : (he'=0) & (pc'={pc+1});
[] cte=3 & he=0 & a=0 & pc={pc} -> 1 : (pc'={pc+1});
[] cte=3 & he=0 & a=1 & pc={pc} -> 1 : (cte'=-1) & (pc'={fail_states[0]}); // error
[] cte=3 & he=0 & a=2 & pc={pc} -> 1 : (cte'=1) & (he'=2) & (pc'={pc+1});
[] cte=3 & he=1 & a=0 & pc={pc} -> 1 : (cte'=-1) & (pc'={fail_states[0]}); // error
[] cte=3 & he=1 & a=2 & pc={pc} -> 1 : (he'=0) & (pc'={pc+1});
[] cte=3 & he=2 & a=0 & pc={pc} -> 1 : (cte'=1) & (pc'={pc+1});
[] cte=3 & he=2 & a=1 & pc={pc} -> 1 : (he'=0) & (pc'={pc+1});
// right -side dynamics:
[] cte=2 & he=0 & a=0 & pc={pc} -> 1 : (pc'={pc+1});
[] cte=2 & he=0 & a=1 & pc={pc} -> 1 : (cte'=0) & (he'=1) & (pc'={pc+1});
[] cte=2 & he=0 & a=2 & pc={pc} -> 1 : (cte'=4) & (he'=2) & (pc'={pc+1});
[] cte=2 & he=1 & a=0 & pc={pc} -> 1 : (cte'=0) & (pc'={pc+1});
[] cte=2 & he=1 & a=2 & pc={pc} -> 1 : (he'=0) & (pc'={pc+1});
[] cte=2 & he=2 & a=0 & pc={pc} -> 1 : (cte'=4) & (pc'={pc+1});
[] cte=2 & he=2 & a=1 & pc={pc} -> 1 : (he'=0) & (pc'={pc+1});
[] cte=4 & he=0 & a=0 & pc={pc} -> 1 : (pc'={pc+1});
[] cte=4 & he=0 & a=1 & pc={pc} -> 1 : (cte'=2) & (he'=1) & (pc'={pc+1});
[] cte=4 & he=0 & a=2 & pc={pc} -> 1 : (cte'=-1) & (pc'={fail_states[0]}); // error
[] cte=4 & he=1 & a=0 & pc={pc} -> 1 : (cte'=2) & (pc'={pc+1});
[] cte=4 & he=1 & a=2 & pc={pc} -> 1 : (he'=0) & (pc'={pc+1});
[] cte=4 & he=2 & a=0 & pc={pc} -> 1 : (cte'=-1) & (pc'={fail_states[0]}); // error
[] cte=4 & he=2 & a=1 & pc={pc} -> 1 : (he'=0) & (pc'={pc+1});
'''
        return [PAST.PrismVerbatim(lines.split("\n"))]
    return dynamics_lines

def taxi_shielded_confpred_model(conf_pred_cte,conf_pred_he,tempest_pred,action_filter,n_est,minimize,label):

    cte=PAST.PrismVar("cte",-1,4,0,enum_low=0)
    he=PAST.PrismVar("he",-1,2,0,enum_low=0)
    cte_est_vars=[PAST.PrismVar(f"cte_est{i}",-1,4,0,enum_low=0) for i in range(n_est)]
    he_est_vars=[PAST.PrismVar(f"he_est{i}",-1,2,0,enum_low=0,enum_high=2) for i in range(n_est)]
    a=PAST.PrismVar("a",0,2,0)
    variables=[cte,he,a]+cte_est_vars+he_est_vars
    
    state=["cte","he"]
    cte_ests=[f"cte_est{i}" for i in range(n_est)]
    he_ests=[f"he_est{i}" for i in range(n_est)]
    state_est=cte_ests+he_ests
    action=["a"]
    fail_states=["dyn_fail"]

    
    
    # perciever
    cte_perceiver = PC.define_perceiver_from_conf_mat("Perceiver (CTE)",["cte"],cte_ests,conf_pred_cte)
    he_perceiver = PC.define_perceiver_from_conf_mat("Perceiver (HE)",["he"],he_ests,conf_pred_he)

    # controller
    tsc = TSC.tempest_shielded_controller(tempest_pred,lambda a_p : a_p[1]>action_filter, minimize)
    controller = PC.PrismComponent("Controller",state_est,action,[],tsc)

    # dynamics
    dynamics = PC.PrismComponent("Dynamics",state+action,state,fail_states,dynamics_logic)


    components=[cte_perceiver,he_perceiver,controller,dynamics]
    
    return PLSM.PrismLoopingStateMachine("ShieldedConfPred",label,"mdp",components,variables,fail_states)


def main():
    parser = argparse.ArgumentParser(description="CLI for building PRISM model from conformal prediction and shielded controller")

    # parser.add_argument("--cte", required=True, type=str, help="Filename of cte sample")
    # parser.add_argument("--he", required=True, type=str, help="Filename of he sample")

    parser.add_argument("--conformal_pred_cte","-cpcte",required=True,type=str, help="Conformal prediction model file (CSV)")
    parser.add_argument("--conformal_pred_he","-cphe",required=True,type=str, help="Conformal prediction model file (CSV)")
    parser.add_argument("--num_est","-ne",required=True,type=int,help="Number of states estimated by conformal predictor")
    parser.add_argument("--tempest_pred","-tp",required=True,type=str,help="Tempest action probability predictions (CSV)")
    parser.add_argument("--action_filter","-af",required=True,type=float,help="Probability filter for shield generation ([0..1])")
    # parser.add_argument('--minimize', action=argparse.BooleanOptionalAction)
    parser.add_argument("--label", "-l", required=True, type=str, help="Instance label, used to differentiate models with distinct data")
    # parser.add_argument("--model", "-m", required=True, type=str, help="Prism model name")

    args = parser.parse_args()

    # minimize does not decrease time, ommitting
    plsm = taxi_shielded_confpred_model(args.conformal_pred_cte,args.conformal_pred_he,args.tempest_pred,args.action_filter,args.num_est,False,args.label)
    plsm.save_to_file()
    
if __name__=="__main__":
    main()
