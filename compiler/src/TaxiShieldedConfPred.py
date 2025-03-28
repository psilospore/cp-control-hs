import argparse

import PrismComponent as PC
import LoopingStateMachine as PLSM
import PrismAST as PAST
import TempestToShieldedController as TSC
from Util import *
import DataLoader as DL

# encodes zero count as negative probability (to avoid float comparison and prism sum < 1 error)
def conf_mat_count_to_prob(conf_mat_count):
    conf_mat_sums = mapL(lambda row : sum(row),conf_mat_count)
    return mapL(lambda row_sum : mapL(lambda x : x/row_sum[1] if x!=0 else -1, row_sum[0]), zip(conf_mat_count,conf_mat_sums))

# Extracts default action functionality to separate component. Required for verify to work.
def default_control(_,action,fail_states):
    def default_control_func(pc):
        lines = f'''
[] default=1 & beta<N & pc={pc} -> (default'=0) & (a'=0) & (beta'=beta+1) & (pc'={pc+1});
[] default=1 & beta=N & pc={pc} -> (default'=0) & (a'=0) & (pc'={pc+1}); // shoud never occur
[] default=0 & pc={pc} -> (pc'={pc+1});'''
        return [PAST.PrismVerbatim(lines.split("\n"))]
    return default_control_func
        
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

def taxi_shielded_confpred_model(conf_pred_cte,conf_pred_he,tempest_pred,action_filter,minimize,label):

    cte_high=4
    he_high=2
    cte=PAST.PrismVar("cte",-1,4,0,enum_low=0)
    he=PAST.PrismVar("he",-1,2,0,enum_low=0)
    default=PAST.PrismVar("default",0,1,0,desc="Flag to trigger default control")
    beta=PAST.PrismVar("beta",0,"N",0,desc="Counts number of times controller found no safe actions")
    cte_est_vars=[PAST.PrismVar(f"cte_est{i}",0,1,0) for i in range(cte_high+1)]
    he_est_vars=[PAST.PrismVar(f"he_est{i}",0,1,0) for i in range(he_high+1)]
    a=PAST.PrismVar("a",0,2,0)
    variables=[cte,he,a,default,beta]+cte_est_vars+he_est_vars
    
    state=["cte","he"]
    cte_ests=[f"cte_est{i}" for i in range(cte_high+1)]
    he_ests=[f"he_est{i}" for i in range(he_high+1)]
    state_est=cte_ests+he_ests
    action=["a"]
    no_safe_as=["beta"]
    fail_states=["dyn_fail"]
    

    
    
    # perciever
    cte_conf_mat_count = mapL(lambda row : mapL(lambda x : int(x),row),DL.read_csv_to_tuples(conf_pred_cte))
    cte_conf_mat_prob = conf_mat_count_to_prob(cte_conf_mat_count)
    cte_perceiver = PC.define_perceiver_from_conf_mat("Perceiver (CTE)",["cte"],cte_ests,cte_conf_mat_prob)
    
    he_conf_mat_count = mapL(lambda row : mapL(lambda x : int(x),row),DL.read_csv_to_tuples(conf_pred_he))
    he_conf_mat_prob = conf_mat_count_to_prob(he_conf_mat_count)
    he_perceiver = PC.define_perceiver_from_conf_mat("Perceiver (HE)",["he"],he_ests,he_conf_mat_prob)

    # controller
    tsc = TSC.tempest_shielded_controller(tempest_pred,lambda a_p : a_p[1]>action_filter, minimize)
    controller = PC.PrismComponent("Controller",state_est,action+no_safe_as,fail_states[1:],tsc)

    # default controller
    # triggered when controller cannot find a safe action (default=1)
    def_controller = PC.PrismComponent("Default Controller",[],action,[],default_control)
    
    # dynamics
    dynamics = PC.PrismComponent("Dynamics",state+action,state,fail_states[:1],dynamics_logic)


    components=[cte_perceiver,he_perceiver,controller,def_controller,dynamics]

    description = [f"--conf_pred_cte {conf_pred_cte}",f"--conf_pred_he {conf_pred_he}",f"--tempest_pred {tempest_pred}",f"--action_filter {action_filter}"]
    return PLSM.PrismLoopingStateMachine("ShieldedConfPred",label,"mdp",components,variables,fail_states,description=description)


def main():
    parser = argparse.ArgumentParser(description="CLI for building PRISM model from conformal prediction and shielded controller")

    # parser.add_argument("--cte", required=True, type=str, help="Filename of cte sample")
    # parser.add_argument("--he", required=True, type=str, help="Filename of he sample")

    parser.add_argument("--conformal_pred_cte","-cpcte",required=True,type=str, help="Conformal prediction model file (CSV)")
    parser.add_argument("--conformal_pred_he","-cphe",required=True,type=str, help="Conformal prediction model file (CSV)")
    parser.add_argument("--tempest_pred","-tp",required=True,type=str,help="Tempest action probability predictions (CSV)")
    parser.add_argument("--action_filter","-af",required=True,type=float,help="Probability filter for shield generation ([0..1])")
    # parser.add_argument('--minimize', action=argparse.BooleanOptionalAction)
    parser.add_argument("--label", "-l", required=True, type=str, help="Instance label, used to differentiate models with distinct configuration")
    # parser.add_argument("--model", "-m", required=True, type=str, help="Prism model name")

    args = parser.parse_args()

    # minimize does not decrease time, ommitting
    plsm = taxi_shielded_confpred_model(args.conformal_pred_cte,args.conformal_pred_he,args.tempest_pred,args.action_filter,False,args.label)
    plsm.save_to_file()
    
if __name__=="__main__":
    main()
