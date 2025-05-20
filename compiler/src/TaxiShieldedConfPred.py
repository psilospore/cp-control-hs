import argparse

import PrismComponent as PC
import LoopingStateMachine as PLSM
import PrismAST as PAST
import TempestToShieldedController as TSC
from Util import *
import DataLoader as DL

DYN_SUCC = 0.9

# encodes zero count as negative probability (to avoid float comparison and prism sum < 1 error)
def conf_mat_count_to_prob(conf_mat_count):
    conf_mat_sums = mapL(lambda row : sum(row),conf_mat_count)
    return mapL(lambda row_sum : mapL(lambda x : x/row_sum[1] if x!=0 else -1, row_sum[0]), zip(conf_mat_count,conf_mat_sums))

def conf_pred_conf_mat_agg(data,var_low,var_high):
    diff = var_high+1-var_low
    agg_vals = [[0]*(2**diff) for i in range(diff)]
        
    for d in data:
        dint  = mapL(int,d)        
        total = sum(dint[i+1]*2**(diff-1-i) for i in range(diff))
        agg_vals[dint[0]+var_low][total]+=1

    return agg_vals

# Extracts default action functionality to separate component. Required for verify to work.
def default_control(_,action,fail_states):
    def default_control_func(pc):
        lines = f'''
[] (default=1 | default=2) & pc={pc} -> (default'=0) & (pc'={fail_states[0]});
[] default=0 & pc={pc} -> (pc'={pc+1});
'''
# [] default=1 & beta1<N & pc={pc} -> (default'=0) & (a'=0) & (beta1'=beta1+1) & (pc'={pc+1});
# [] default=1 & beta1=N & pc={pc} -> (default'=0) & (a'=0) & (pc'={pc+1}); // shoud never occur
# [] default=2 & beta2<N & pc={pc} -> (default'=0) & (a'=0) & (beta2'=beta2+1) & (pc'={pc+1});
# [] default=2 & beta2=N & pc={pc} -> (default'=0) & (a'=0) & (pc'={pc+1}); // shoud never occur
# [] default=0 & pc={pc} -> (pc'={pc+1});'''
        return [PAST.PrismVerbatim(lines.split("\n"))]
    return default_control_func

def dynamics_stoch(dyn_succ):
    dyn_fail=(1-dyn_succ)/2
    def dynamics_stoch_func(state_action,state,fail_states):
        def dynamics_lines(pc):
            lines=f'''
[] a=0 & pc={pc} -> {dyn_succ} : (a'=0) & (pc'={pc+1}) + {dyn_fail} : (a'=1) & (pc'={pc+1}) + {dyn_fail} : (a'=2) & (pc'={pc+1});
[] a=0 & pc={pc} -> {dyn_succ} : (a'=0) & (pc'={pc+1}) + {dyn_fail} : (a'=1) & (pc'={pc+1}) + {dyn_fail} : (a'=2) & (pc'={pc+1});
[] a=0 & pc={pc} -> {dyn_succ} : (a'=0) & (pc'={pc+1}) + {dyn_fail} : (a'=1) & (pc'={pc+1}) + {dyn_fail} : (a'=2) & (pc'={pc+1});
'''
            return [PAST.PrismVerbatim(lines.split("\n"))]
        return dynamics_lines
    return dynamics_stoch_func

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
    default=PAST.PrismVar("default",0,2,0,desc="Enum to trigger default control")
    beta1=PAST.PrismVar("beta1",0,"N",0,desc="Counts number of times controller found no safe actions")
    beta2=PAST.PrismVar("beta2",0,"N",0,desc="Counts number of times empty state was estimated")
    cte_est_vars=[PAST.PrismVar(f"cte_est{i}",0,1,0) for i in range(cte_high+1)]
    he_est_vars=[PAST.PrismVar(f"he_est{i}",0,1,0) for i in range(he_high+1)]
    a=PAST.PrismVar("a",0,2,0)
    variables=[cte,he,a,default]+cte_est_vars+he_est_vars
    
    state=["cte","he"]
    cte_ests=[f"cte_est{i}" for i in range(cte_high+1)]
    he_ests=[f"he_est{i}" for i in range(he_high+1)]
    state_est=cte_ests+he_ests
    action=["a"]
    # no_safe_as=["beta1","beta2"]
    fail_states=["dyn_fail","ctrl_fail"]
    

    
    
    # perciever
    cte_data = DL.read_csv_to_tuples(conf_pred_cte,skip_header=True)
    cte_conf_mat_count = conf_pred_conf_mat_agg(cte_data,0,4)
    # cte_conf_mat_count = mapL(lambda row : mapL(lambda x : int(x),row),DL.read_csv_to_tuples(conf_pred_cte))
    cte_conf_mat_prob = conf_mat_count_to_prob(cte_conf_mat_count)
    cte_perceiver = PC.define_perceiver_from_conf_mat("Perceiver (CTE)",["cte"],cte_ests,cte_conf_mat_prob)
    
    he_data = DL.read_csv_to_tuples(conf_pred_he,skip_header=True)
    he_conf_mat_count = conf_pred_conf_mat_agg(he_data,0,2)
    # he_conf_mat_count = mapL(lambda row : mapL(lambda x : int(x),row),DL.read_csv_to_tuples(conf_pred_he))
    he_conf_mat_prob = conf_mat_count_to_prob(he_conf_mat_count)
    he_perceiver = PC.define_perceiver_from_conf_mat("Perceiver (HE)",["he"],he_ests,he_conf_mat_prob)

    # controller
    tsc = TSC.tempest_shielded_controller(tempest_pred,lambda a_p : a_p[1]>action_filter, minimize)
    controller = PC.PrismComponent("Controller",state_est,action,fail_states[1:],tsc)

    # default controller
    # triggered when controller cannot find a safe action (default=1)
    def_controller = PC.PrismComponent("Default Controller",[],action,["ctrl_fail"],default_control)
    
    # dynamics
    stoch_dyn = PC.PrismComponent("Stochastic Dynamics",action,action,[],dynamics_stoch(DYN_SUCC))
    dynamics = PC.PrismComponent("Dynamics",state+action,state,fail_states[:1],dynamics_logic)


    components=[cte_perceiver,he_perceiver,controller,def_controller,stoch_dyn,dynamics]

    description = [f"--conf_pred_cte {conf_pred_cte}",f"--conf_pred_he {conf_pred_he}",f"--tempest_pred {tempest_pred}",f"--action_filter {action_filter}"]
    return PLSM.PrismLoopingStateMachine("ShieldedConfPred",label,"mdp",components,variables,fail_states,description=description)


def stats(args):
    he_data = DL.read_csv_to_tuples(args.conformal_pred_he,skip_header=True)
    he_conf_mat_count = conf_pred_conf_mat_agg(he_data,0,2)
    he_conf_mat_prob = conf_mat_count_to_prob(he_conf_mat_count)

    cte_data = DL.read_csv_to_tuples(args.conformal_pred_cte,skip_header=True)
    cte_conf_mat_count = conf_pred_conf_mat_agg(cte_data,0,4)
    cte_conf_mat_prob = conf_mat_count_to_prob(cte_conf_mat_count)
 
    tempest_model_dict = TSC.tempest_model_to_dict(DL.read_csv_to_tuples(args.tempest_pred,skip_header=True))
    shield = TSC.tempest_model_to_shield(tempest_model_dict,lambda ap:ap[1]>float(args.action_filter))
    
    def conf_pred_hit_ratios(data,var_low,var_high):
        diff = var_high+1-var_low
        hit_counts = [0]*diff
        total_counts = [0]*diff
        
        for d in data:
            dint = mapL(int,d)
            hit = dint[1+dint[0]]
            hit_counts[dint[0]]+=hit
            total_counts[dint[0]]+=1
    
        return mapL(lambda hc_tc : hc_tc[0]/hc_tc[1], zip(hit_counts,total_counts))

    # prediction performance (prob of estimating correct state)
    cte_hr = conf_pred_hit_ratios(cte_data,0,4)
    he_hr = conf_pred_hit_ratios(he_data,0,2)

    def encode_woven(n,val):
        sv = val-n//2
        return int(abs(sv)*2-(1 if sv<0 else 0))

    conj_hr = [[(cte_hr[i]*he_hr[j]) for i in mapL(lambda i : encode_woven(5,i),range(5))] for j in mapL(lambda j : encode_woven(3,j),range(0,3))]
    print(conj_hr)

    import matplotlib.pyplot as plt

    # plt.imshow(conj_hr, cmap='gray', vmin=0, vmax=1)
    # plt.axis('off')  # Hide axis for cleaner display
    # plt.show()

    # # shielding performance (prob not getting stuck)

    def conf_pred_stuck_ratio(cte_data,he_data,shield):
        def get_states_from_int_encode(cte_i,he_i):
            cte_ests = [i for i in range(5) if (cte_i//(2**i))%2==1]
            he_ests =  [i for i in range(3) if (he_i//(2**i))%2==1]
            # print(cte_ests,he_ests)
            return [(cte_est,he_est) for cte_est in cte_ests for he_est in he_ests]
        
        count_stuck = [[(0,0) for i in range(0,5)] for j in range(0,3)]
        for cte in range(0,5):
            for he in range(0,3):
                for cte_i in range(2**5):
                    for he_i in range(2**3):
                        states = get_states_from_int_encode(cte_i,he_i)
                        safe_actions = [] if not states else inner_reduce(lambda x,y : x.intersection(y),[shield(*state) for state in states])
                        prob_cte = cte_data[cte][cte_i]
                        prob_he = he_data[he][he_i] 
                        prob = prob_cte*prob_he if prob_cte!=-1 and prob_he!=-1 else 0
                        if prob!=0: 
                            print(cte_i,he_i,states,safe_actions,prob)
                        cs = count_stuck[he][cte]
                        cs = (cs[0]+prob,cs[1]+prob) if safe_actions else (cs[0],cs[1]+prob)
                        count_stuck[he][cte] = cs
        return [[count_stuck[j][i] for i in mapL(lambda i : encode_woven(5,i),range(5))] for j in mapL(lambda j : encode_woven(3,j),range(0,3))]

    
    stuck_ratio = conf_pred_stuck_ratio(cte_conf_mat_prob,he_conf_mat_prob,shield)
    print(stuck_ratio)
    plt.imshow(mapL(lambda l : mapL(lambda x:x[0]**3,l),stuck_ratio), cmap='gray', vmin=0, vmax=1)
    plt.axis('off')  # Hide axis for cleaner display
    plt.show()

    
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

    # minimize does not decrease time, setting False
    plsm = taxi_shielded_confpred_model(args.conformal_pred_cte,args.conformal_pred_he,args.tempest_pred,args.action_filter,False,args.label)
    plsm.save_to_file()
    print("writing model to",plsm.filename)

    # stats
    # stats(args)
    
if __name__=="__main__":
    main()
