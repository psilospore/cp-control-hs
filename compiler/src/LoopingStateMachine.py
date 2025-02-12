import BayesianModel as BM
import PrismAST as PAST
from Util import *
import PrismExec as PE
import PrismComponent as PC

import datetime
from dataclasses import dataclass


# 0: component 0
# 1: component 1
# ...
# loop_max: loop step
# -1: fail state 0
# ...
# -n: fail_state n-1
class PrismLoopingStateMachine:
    def __init__(self,module_name,version,components: [PC.PrismComponent],statevars: [PAST.PrismVar],fail_states: [str]):
        self.module_name=module_name
        self.version=version
        self.components=components
        self.fail_states=fail_states
        self.filename = f"./bin/{self.module_name}-{self.version}.pm"
        self.written=False


        self.statevar_dict={pv.name:pv for pv in statevars}
        self.loop_max = len(self.components)
        self.fail_state_pc_dict = {fail_states[i]:-i-1 for i in range(len(fail_states))}
        
        pc_var = PAST.PrismVar("pc",-len(fail_states),self.loop_max,0,"program counter")
        loop_var = PAST.PrismVar("k",0,"N",1,"loop counter")

        self.pvars = statevars+[pc_var,loop_var]

        self.loop_step = PAST.PrismTrans(f"pc={self.loop_max} & k < N",[("(pc'=0) & (k'=k+1)",1)])

    def __str__(self):
        indent="  "
        variable_declr = composeLines(indent,self.pvars)
        pc_vals = list(range(0,self.loop_max)) # ignores fail states
        component_logics = [
            f"{indent}// {c.name}\n"+
            composeLines(indent,c.logic(
                mapL(dict_to_func(self.statevar_dict),c.invars),
                mapL(dict_to_func(self.statevar_dict),c.outvars),
                mapL(dict_to_func(self.fail_state_pc_dict),c.fail_states))(pc))
            for pc,c in zip(pc_vals,self.components)]
        loop_rep = composeLines(indent,[self.loop_step])
        
        pc_summary="// PC values:\n"
        for pc,c in zip(pc_vals,self.components):
            pc_summary+=f"//   {pc} : {c.name}\n"
        pc_summary+=f"//   {self.loop_max} : Loop Logic\n"
        for i in range(len(self.fail_states)):
            pc_summary+=f"//   {-i-1} : {self.fail_states[i]}\n"
            
        cl_rep = ""
        for cl in component_logics:
            cl_rep+=cl+"\n"
                    
        return f"""
// {self.module_name}
// Prism Looping State Machine
// Generated: {datetime.datetime.now()}
{pc_summary}

dtmc

const N;

module {self.module_name}

{variable_declr}

{cl_rep}

  // Loop Logic
{loop_rep}

endmodule
"""

    def save_to_file(self):
        if self.written:
            return
        self.written=True
        # print("writing to "+self.filename)
        with open(self.filename, "wt") as f:
            f.write(str(self))


    def test_property(self,prism_property,consts):
        if not self.written:
            self.save_to_file()
        return PE.run_prism(self.filename,prism_property.filename,1,consts)

    
