import PrismAST as PAST
from Util import *

from functools import reduce
import subprocess


def one_hot(var_range,val):
    return [1 if i==val else 0 for i in var_range]

def one_hot_inv(var_range,oh_encode):
    for i in range(len(oh_encode)):
        if oh_encode[i]==1 or oh_encode[i]=="1":
            return i-var_range[0]
    raise Exception("One hot decode fail",oh_encode)

# ([PrismVar], [PrismVar], ([VarAssign] -> [VarAssign])) -> ([[OneHot]],[[OneHot]])
def build_one_hot_function(in_vars,out_vars,comp_func):

    one_hot_input = []
    one_hot_output = []


    str_add = lambda x,y: str(x)+str(y)
    vl_enum = PAST.var_list_to_enumerable(in_vars)
    for pv_assign in vl_enum.enumerate_pv():

        one_hot_input_current = ""
        for var,assign in zip(in_vars,pv_assign):
            one_hot_input_current+=inner_reduce(str_add,one_hot(var.enum_range(), assign[1]))

        result = comp_func(pv_assign)

        one_hot_output_current = ""
        for var,assign in zip(out_vars,result):
            one_hot_output_current+=inner_reduce(str_add,one_hot(var.enum_range(), assign[1]))

        one_hot_input.append(one_hot_input_current)
        one_hot_output.append(one_hot_output_current)

    return one_hot_input,one_hot_output

    
def generate_espresso_input(oh_input,oh_output):
    p = len(oh_input)
    i = len(oh_input[0])
    o = len(oh_output[0])

    oh_str=lambda l:reduce(lambda x,y : str(x)+str(y), l, "")

    lines = reduce(lambda x,y : x+"\n"+y, map(lambda oh : oh_str(oh[0])+" "+oh_str(oh[1]), zip(oh_input,oh_output)), "")
    
    return f"""
.i {i}
.o {o}
.p {p}
{lines}
.e
"""

def run_espresso(input_pla):
    """Run espresso on a given PLA input and return minimized logic."""
    proc = subprocess.Popen(
        ["espresso","-Dpair"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
    )
    output, _ = proc.communicate(input_pla)
    # print(output)
    return output.strip()


from dataclasses import dataclass
from parse import parse

@dataclass
class Not:
    val: str
    def __str__(self):
        if isinstance(self.val,Eq):
            return f"{self.val.l} != {self.val.r}"
        return f"Not {self.val}"
    
@dataclass
class And:
    v1: str
    v2: str
    def __str__(self):
        return f"({self.v1}) & ({self.v2})"

@dataclass
class Or:
    v1: str
    v2: str
    def __str__(self):
        return f"({self.v1}) | ({self.v2})"

@dataclass
class Eq:
    l: str
    r: str
    def __str__(self):
        return f"{self.l}={self.r}"

@dataclass
class AndList:
    ands: [And]
    def __str__(self):
        return inner_reduce(lambda x,y: str(And(x,y)), self.ands)

# this function is extremely slow (major bottleneck)
def bubble_or(ex):
    # print(ex)
    if isinstance(ex,And):
        foundOr=False
        ov1 = bubble_or(ex.v1)
        ov2 = bubble_or(ex.v2)
        if isinstance(ov1,Or):
            a=ov1.v1
            b=ov1.v2
            c=ov2
            foundOr=True
        if isinstance(ov2,Or):
            a=ov2.v1
            b=ov2.v2
            c=ov1
            foundOr=True
        if foundOr:
            oa=a 
            ob=b 
            oc=c 
            return Or(bubble_or(And(oa,oc)),bubble_or(And(ob,oc)))
        return And(ov1,ov2)
    if isinstance(ex,Or):
        return Or(bubble_or(ex.v1),bubble_or(ex.v2))
    return ex

# assumes ors above ands
def reconcile_assign(ex):
    # print(ex)
    def rec_assign_lists(al1,al2):
        l1=al1.ands
        l2=al2.ands
        for_del1 = [False]*len(l1)
        for_del2 = [False]*len(l2)
        for i in range(len(l1)):
            for j in range(len(l2)):
                e1=l1[i]
                e2=l2[j]
                if isinstance(e1,Eq) and isinstance(e2,Not) and e1.l == e2.val.l:
                    for_del2[j]=True
                if isinstance(e2,Eq) and isinstance(e1,Not) and e2.l == e1.val.l:
                    for_del1[i]=True
        return AndList([l1[i] for i in range(len(l1)) if not for_del1[i]] + [l2[i] for i in range(len(l2)) if not for_del2[i]])
    
    if isinstance(ex,Eq):
        return AndList([ex])
    if isinstance(ex,Not):
        return AndList([ex])
    if isinstance(ex,And):
        assign_v1=reconcile_assign(ex.v1)
        assign_v2=reconcile_assign(ex.v2)
        return rec_assign_lists(assign_v1,assign_v2)
    if isinstance(ex,Or):
        return Or(reconcile_assign(ex.v1),reconcile_assign(ex.v2))
    print("rec_assign: didn't match",ex)
    
def read_pair(bits,varpair):
    conj = []
    add_not = lambda l,v: Not(v) if l==1 else v
    for i in range(2):
        for j in range(2):
            if bits[2*i+j]=="1":
                conj.append((add_not(i,varpair[0]) ,add_not(j,varpair[1])))
    return conj

# String -> OneHotPaired
def read_paired_simplification(result):
    rs=result.split("\n")
    # print(rs)
    pairs = list(map(lambda s: list(map(lambda x : int(x)-1, s.split(" "))), parse("# pair is {}",rs[0])[0][1:-1].split(") (")))
    # print(pairs)
    i=1
    def get_start(string):
        parsed = parse(".{} {}",rs[i])
        if not parsed is None:
            return parsed[0]
        return None
    
    start=None
    while start!="p":
        start = get_start(rs[i])
        i+=1
        
    bit_lines = []
    while i<len(rs) and rs[i]!=".e":
        bit_lines.append(rs[i])
        i+=1

    conj=[]
    for bl in bit_lines:
        bitquarts = bl.split(" ")[1:]
        #print(bitquarts)
        cconj=[]
        for bq,pair in zip(bitquarts,pairs):
            cconj.append(read_pair(bq,pair))
        
        conj.append((cconj,one_hot_inv(range(0,len(bitquarts[-1])),bitquarts[-1])))

    # print(conj)
    return conj    

# OneHotDecode : Int -> (var,val)
def one_hot_decode(var):
    return [(var.name,i) for i in range(var.enum_low,var.enum_high+1)]

# OneHotDecodeFunc : [PrismVar],[PrismVar] -> OneHotDecode,OneHotDecode
def one_hot_decode_func(invars,outvars):
    add=lambda x,y : x+y
    invar_decode=reduce(add,map(one_hot_decode,invars),[])
    outvar_decode=reduce(add,map(one_hot_decode,outvars),[])
    return invar_decode,outvar_decode

    
# OneHotDecodeFunc -> OneHotPaired -> 
def simplified_one_hot_controller(one_hot_decode_func, one_hot_paired):
    oh_decode_in,oh_decode_out = one_hot_decode_func

    def decode(decoder,v):
        if isinstance(v,Not):
            return Not(decoder[v.val])
        else:
            return decoder[v]

    decoded=[]
    for line in one_hot_paired:
        in_coded = line[0]
        out_coded = line[1]
        in_decoded = [[(decode(oh_decode_in,v1),decode(oh_decode_in,v2)) for (v1,v2) in in_coded_line] for in_coded_line in in_coded]
        out_decoded = decode(oh_decode_out,out_coded)
        decoded.append((in_decoded,out_decoded))

    # print(decoded)

    # wraps equality around assignment
    def assign_toEq(assign):
        if isinstance(assign,Not):
            return Not(Eq(*assign.val))
        else:
            return Eq(*assign)

    trans = []
    for line in decoded:
        cond = line[0]
        result = line[1]
        sresult = assign_toEq(result)
        # print(sresult)
        scond = inner_reduce(And,[inner_reduce(Or,[And(assign_toEq(v1),assign_toEq(v2)) for (v1,v2) in cond_line]) for cond_line in cond])
        simp_scond = reconcile_assign(bubble_or(scond))
        trans.append(PAST.PrismTrans(str(simp_scond),[(f"({sresult})",1)]))
        #print(trans[-1])
    return trans

# ([PrismVar], [PrismVar], ([VarAssign] -> [VarAssign])) -> [PrismTrans]
def minimize_component(in_vars,out_vars,comp_func):

    # modifies outvar names for correct generation
    for var in out_vars:
        var.name+="'"
        
    one_hot_input,one_hot_output = build_one_hot_function(in_vars,out_vars,comp_func)

    espresso_in = generate_espresso_input(one_hot_input,one_hot_output)

    # print("espresso in\n",espresso_in)
    # print("end espresso in")
    
    espresso_out =  run_espresso(espresso_in)

    # print("espresso out\n",espresso_out)
    # print("end espresso out")
    paired_encoded = read_paired_simplification(espresso_out)

    oh_decode_func = one_hot_decode_func(in_vars,out_vars)
    # print("decoder",oh_decode_func)
    
    return simplified_one_hot_controller(oh_decode_func,paired_encoded)

if __name__=="__main__":
    cte    = PAST.PrismVar("cte",-4,4,0,enum_low=-2,enum_high=2)
    he     = PAST.PrismVar("he",-2,2,0,enum_low=-1,enum_high=1)
    action = PAST.PrismVar("action",-2,2,0,enum_low=-1,enum_high=1)

    invars=[cte,cte,cte,he,he,he]
    outvars=[action]
    import ShieldBuilder as SB
    print(inner_reduce(str_comb("\n"),list(map(lambda x:inner_reduce(lambda x,y : x+y,x.toPrismLines()),minimize_component(invars,outvars,SB.controller)))))

    
