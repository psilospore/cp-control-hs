import BayesianModel as BM
import PrismAST as PAST
from Util import *
import PrismExec as PE
import DataLoader as DL

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

# modified to work with nondeterministic transitions
# func : [Assign vl for vl in var_list] -> [[PrismAssign a]]
# define_component_by_enumeration_ND : (var_list, func) -> [NDPrismTrans]
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



# used for conformal prediction
# assumes in_var and out_var enumeration matches csv order
def define_perceiver_from_conf_mat(name,in_var_names,out_var_names,conf_mat):
    # print("conf_mat dims: ",len(conf_mat),len(conf_mat[0]))
    
    def perceiver(in_var,out_var,_):
        def perciever_func(pc):
            iv_enum = PAST.var_list_to_enumerable(in_var).enumerate_pv()
            ov_enum = PAST.var_list_to_enumerable(out_var).enumerate_pv()
            assert len(conf_mat)==len(iv_enum), f"input variable enumeration length does not match conformal prediction csv rows {len(conf_mat)}!={len(iv_enum)}"
            assert len(conf_mat[0])==len(ov_enum), f"output vairable enumeration length does not match conformal prediction csv columns {len(conf_mat[0])}!={len(ov_enum)}"
            print("WARNING: assuming conformal prediction csv order")
            print("Columns",str(iv_enum))
            print("Rows",str(ov_enum))
            transitions=[]
            land = lambda x,y : x+" & "+y
            for i in range(len(iv_enum)):
                iv_assign=iv_enum[i]
                lhs = inner_reduce(land, [f"{iva[0]}={iva[1]}" for iva in iv_assign])
                rhs=[]
                for j in range(len(ov_enum)):
                    ov_assign=ov_enum[j]
                    rhs_cond = inner_reduce(land, [f"({ova[0]}'={ova[1]})" for ova in ov_assign])
                    prob = conf_mat[i][j]
                    if prob>=0:
                        rhs.append((rhs_cond,prob))
                pt = PAST.PrismTrans(lhs,rhs)
                pt.addPC(pc)
                transitions.append(pt)
            return transitions
        return perciever_func
    return PrismComponent(name,in_var_names,out_var_names,[],perceiver)

                

                
