import DataLoader as DL
import BayesianModel as BM


## Model: GT -> OBS

class ConfusionMatrix(BM.BayesianNetworkWrapper):
    def __init__(self,sample_file,reverse=False):
        sample = DL.read_csv_as_pairs(sample_file)
        nodes=["gt","obs"]
        edges=[("gt","obs")] if not reverse else [("obs","gt")]
        self.out_var='obs' if not reverse else 'gt'
        super().__init__(nodes,edges)
        self.fit(sample)

    # ConfusionMatrix -> (Int,Int) -> Prob 
    def read_model(self):
        def from_model(gt,obs):
            # print(self.model.get_cpds('obs'))
            # print("read_conf_mat -> from_model",gt,obs)
            return self.model.get_cpds(self.out_var).to_factor().get_value(gt=str(gt),obs=str(obs))
        return from_model
    
    # Used by define_component_by_enumeration in BayesianNetworkWrapper.perceiver_from_est_model
    # (ConfusionMatrix, [PrismVar]) -> (VarInst -> [Assignment])
    def perceive_func_from_read_func(self,est_vars):
        est_var=est_vars[0]
        def perceive_func(args):
            state=args[0][1]
            return [(f"({est_var.name}'={est})",self.read_model()(state,est)) for est in range(est_var.enum_low,est_var.enum_high+1)]
        return perceive_func
