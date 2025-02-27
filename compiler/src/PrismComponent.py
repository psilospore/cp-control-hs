import BayesianModel as BM
import PrismAST as PAST
from Util import *
import PrismExec as PE

from ComponentMinimizer import *

@dataclass
class PrismComponent:
    name    : str
    invars  : [str] # names of input PrismVars
    outvars : [str] # names of output PrismVars
    fail_states : [str]
    #  
    logic: ...  # : ([PrismVar],[PrismVar],[Int]) -> (Int -> [PrismTrans])


    
## Component Builders

# func : [Assign vl for vl in var_list] -> PrismTransition
def define_component_by_enumeration(var_list,func,pc):
    transitions=[]
    vl_enum = PAST.var_list_to_enumerable(var_list)
    for pv_assign in vl_enum.enumerate_pv():
        condition = ""
        for pv,val in pv_assign:
            condition+=f"{pv}={val} & "
        condition=condition[:-2]
        pt = PAST.PrismTrans(condition,func(pv_assign)) 
        pt.addPC(pc)
        transitions.append(pt)
    return transitions

# modified to work with nondeterministic assignment
# func : [Assign vl for vl in var_list] -> [[PrismAssign a]]
def define_component_by_enumeration_ND(var_list,func,pc):
    transitions=[]
    vl_enum = PAST.var_list_to_enumerable(var_list)
    for pv_assign in vl_enum.enumerate_pv():
        condition = inner_reduce(lambda x,y : x+" & "+y,
                    mapL(lambda pv_val : f"{pv_val[0]}={pv_val[1]}",
                    pv_assign))
        
        assignments = mapL(str,func(pv_assign))
        pt = PAST.NDPrismTrans(condition,assignments)
        pt.addPC(pc)
        transitions.append(pt)
    return transitions

# Builds Perceiver Component from BayesianModel

# (((state, state_est) -> Prob),  PrismVar) -> (VarInst -> [Assignment])
def perceive_func_from_read_func(read_func,est_var):
    def perceive_func(args):
        state=args[0][1]
        return [(f"({est_var.name}'={est})",read_func(state,est)) for est in range(est_var.low,est_var.high+1)]
    return perceive_func

# BayesianNetworkWrapper -> ([PrismVar],[PrismVar],[Int]) -> (PC -> [PrismTrans])
def perceiver_from_est_model(model):
    read_func = BM.read_conf_mat(model)  # :: (state,state_est) -> prob
    
    def perceiver(state,state_est,_):

        def perceiver_pc(pc):

            return PAST.define_component_by_enumeration(
                state,
                perceive_func_from_read_func(read_func,state_est[0]),
                pc)
        
        return perceiver_pc

    return perceiver


    
