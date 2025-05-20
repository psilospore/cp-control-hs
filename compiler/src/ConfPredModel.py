from Util import *
import DataLoader as DL
# import BayesianModel as BM

## Model: GT -> OBS*m

# class ConfPredModel(BM.BayesNetworkWrapper):
#     def __init__(self,sample_file,m):
#         sample = DL.read_csv_as_pairs(sample_file)
#         nodes=["gt"]+[f"obs{i}" for i in range(m)]
#         edges=[("gt",f"obs{i}") for i in range(m)]+[(f"obs{i}",f"obs{i+1}") for i in range(m-1)]
#         super().__init__(nodes,edges)
#         self.fit(sample)

#     # calculates the probbaility of the 
#     # ConfPredModel -> (Int,Int*m,i) -> Prob
#     def read_model(self):
#         def from_model(gt,obs_list,i):
#             return self.model.get_cpds(f'obs{i}').to_factor().get_values(gt=str(gt),obs=str(obs_list[-1])) # not correct (needs eval to go over all )


#     def perceive_func_from_read_func(self,est_vars):
#         ev_enum = PAST.var_list_to_enumerable(est_vars)
#         def percieve_func(args):
#             state=args[0][1]
#             for ev_assign = ev_enum.enumerate_pv():
                
                
# builds conformal preduction confusion matrix from observations
# assumes a continuous range of values from var_low to var_high
def conf_pred_conf_mat_agg(data,var_low,var_high):
    diff = var_high+1-var_low
    agg_vals = [[0]*(2**diff) for i in range(diff)]

    for d in data:
        dint  = mapL(int,d)        
        total = sum(dint[i+1]*2**(diff-1-i) for i in range(diff))
        agg_vals[dint[0]+var_low][total]+=1

    return agg_vals

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

    print("        | C=0 | C=1 | C>1 ")
    print(f" No Hit | {stats[0]} | {stats[1]} | {stats[2]}")
    print(f" Hit    | {stats[3]}  | {stats[4]} | {stats[5]}")

if __name__=="__main__":
    
    he_file = "lib/he_pred_sets_0.01.csv"
    he_data = DL.read_csv_to_tuples(he_file,skip_header=True)
    conf_pred_stats(he_data,0,2)
    he_agg = conf_pred_conf_mat_agg(he_data,0,2)
    print(he_agg)

    cte_file = "lib/cte_pred_sets_0.01.csv"
    cte_data = DL.read_csv_to_tuples(cte_file,skip_header=True)
    conf_pred_stats(cte_data,0,4)
    cte_agg = conf_pred_conf_mat_agg(cte_data,0,4)
    print(cte_agg)
