import DataLoader as DL
import BayesianModel as BM

## Model: GT -> OBS*m

class ConfPredModel(BM.BayesNetworkWrapper):
    def __init__(self,sample_file,m):
        sample = DL.read_csv_as_pairs(sample_file)
        nodes=["gt"]+[f"obs{i}" for i in range(m)]
        edges=[("gt",f"obs{i}") for i in range(m)]+[(f"obs{i}",f"obs{i+1}") for i in range(m-1)]
        super().__init__(nodes,edges)
        self.fit(sample)

    # calculates the probbaility of the 
    # ConfPredModel -> (Int,Int*m,i) -> Prob
    def read_model(self):
        def from_model(gt,obs_list,i):
            return self.model.get_cpds(f'obs{i}').to_factor().get_values(gt=str(gt),obs=str(obs_list[-1])) # not correct (needs eval to go over all )


    def perceive_func_from_read_func(self,est_vars):
        ev_enum = PAST.var_list_to_enumerable(est_vars)
        def percieve_func(args):
            state=args[0][1]
            for ev_assign = ev_enum.enumerate_pv():
                
                
