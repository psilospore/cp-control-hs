from TaxiShieldedConfPred import taxi_shielded_confpred_model
from PrismExec import run_prism
import PrismAST as PAST
from Util import *
import DataLoader as DL

def run_prop_on_state_files_in_range(prop,tempest_file,state_files,n):
    data={}
    for name,cte_file,he_file in state_files:
        model = taxi_shielded_confpred_model(cte_file,he_file,tempest_file,0.3,False,f"RealData_{name}")
        model.save_to_file()
        data[name]=[]
        # print(model.filename)
        # print(prop.filename)
        for N in range(2,n):
            # print(".")
            const_assign={"N":N}
            # try:
            prob = run_prism(model.filename,prop.filename,1,const_assign,sim=False)
            # except Exception as e:
                # print(e)
                # prop = None
                
            data[name].append(prob)
    return data


def confperd_minmax_experiment(state_files):

    exp_n = 5
    tempest_file = "lib/temp_extr_dir.csv"

    crash_min = PAST.PrismProp("Pmin=? [F (pc<0)]","bin/Prop_TaxiCrash_Min.pctl")
    crash_max = PAST.PrismProp("Pmax=? [F (pc<0)]","bin/Prop_TaxiCrash_Max.pctl")
    stuck_min = PAST.PrismProp("Pmin=? [F ((beta1>0) | (beta2>0))]","bin/Prop_TaxiStuck_Min.pctl")
    stuck_max = PAST.PrismProp("Pmax=? [F ((beta1>0) | (beta2>0))]","bin/Prop_TaxiStuck_Max.pctl")

    props = [("crash min",crash_min),
             ("crash max",crash_max),
             ("stuck min",stuck_min),
             ("stuck max",stuck_max)]

    n=15
    join_comma = lambda x,y:f"{x}, {y}"
    for name,prop in props:
        # print(name)
        data = run_prop_on_state_files_in_range(prop,tempest_file,state_files,n)
        print(name)
        
        print(","+inner_reduce(join_comma,list(range(2,n))))
        for model_name in data:
            print(f"{model_name}, "+inner_reduce(join_comma,data[model_name]))
        # print(data)
                                                

def conf_pred_stats(data,var_low,var_high):
    diff = var_high+1-var_low
    stats = [0]*6

    for d in data:
        dint = mapL(int,d)
        guesses = sum(dint[1:])
        if guesses>=2:
            guesses=2
        hit = dint[1+dint[0]]
        stats[hit*3+guesses]+=1

    print("        & C=0 & C=1 & C$>$1 \\\\")
    print(f" No Hit & {stats[0]} & {stats[1]} & {stats[2]} \\\\")
    print(f" Hit    & {stats[3]}  & {stats[4]} & {stats[5]} ")

def stats_over_files(state_files):
    for name,cte_file,he_file in state_files:
        he_data = DL.read_csv_to_tuples(he_file,skip_header=True)
        cte_data = DL.read_csv_to_tuples(cte_file,skip_header=True)
        print(name)
        print("CTE")
        conf_pred_stats(cte_data,0,4)
        print("HE")
        conf_pred_stats(he_data,0,2)
        
if __name__=="__main__":
    acc95_state_files = [("acc95_conf95","lib/acc95/real_cte_pred_acc95_conf95.csv","lib/acc95/real_he_pred_acc95_conf95.csv"),
                         ("acc95_conf99","lib/acc95/real_cte_pred_acc95_conf99.csv","lib/acc95/real_he_pred_acc95_conf99.csv"),
                         ("acc95_conf995","lib/acc95/real_cte_pred_acc95_conf995.csv","lib/acc95/real_he_pred_acc95_conf995.csv")]

    acc90_state_files = [("acc90_conf95","lib/acc90/real_cte_pred_acc90_conf95.csv","lib/acc90/real_he_pred_acc90_conf95.csv"),
                         ("acc90_conf99","lib/acc90/real_cte_pred_acc90_conf99.csv","lib/acc90/real_he_pred_acc90_conf99.csv"),
                         ("acc90_conf995","lib/acc90/real_cte_pred_acc90_conf995.csv","lib/acc90/real_he_pred_acc90_conf995.csv")]


        
    # confperd_minmax_experiment(acc95_state_files)
    stats_over_files(acc90_state_files)
    
