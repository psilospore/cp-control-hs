import re
import argparse

import ConfMatModel as CMM
from Util import *




def parse_tempest(tempest_file):

    def extract_numbers(text):
        numbers = re.findall(r'-?\d+\.\d+|-?\d+', text)
        parsed_numbers = [float(num) if '.' in num else int(num) for num in numbers]
        return parsed_numbers

    all_tempest=[]
    with open(tempest_file,"r") as tf:
        lines = tf.read().split("\n")
        for line in lines:
            all_tempest.append(extract_numbers(line))

    unique = lambda x : list(dict.fromkeys(x))
    # cte,he,action0,action1,action2
    of_interest=unique([(l[0],l[1],l[9],l[11],l[13]) for l in all_tempest if len(l)>=14])

    return of_interest


# P(Safe & a | Se) = Sum_S P(Safe & a | S & Se) * P(S | Se)
# P(S | Se) = P(cte_est & he_est | cte & he) = P(cte | cte_est) & P(he | he_est)
# P(Safe | a & Se) = Sum_S P(Safe | a & S & Se) * P(cte_est | cte) & P(he_est | he)

# tempest_out : (cte,he,action0,action1,action2)
def true_to_est_by_marginal(cte_file,he_file,tempest_out):
    cte_cmm=CMM.ConfusionMatrix(cte_file,reverse=True)
    he_cmm=CMM.ConfusionMatrix(he_file,reverse=True)
    print(cte_cmm.model.get_cpds('gt'))
    print(he_cmm.model.get_cpds('gt'))
    # print(cte_cmm.model)
    # print(he_cmm.model)
    
    tempest_dict = {(cte,he):(action0,action1,action2) for cte,he,action0,action1,action2 in tempest_out}
    cte_range=range(0,5)
    he_range=range(0,3)
    action_range=range(0,3)
    
    marg_prob = []
    for cte_est in cte_range:
        for he_est in he_range:
            mp_a=[0 for a in action_range]
            for a in action_range:
                for cte in cte_range:
                    for he in he_range:
                        # print(cte,cte_est,he,he_est)
                        mp_a[a]+=tempest_dict[(cte,he)][a] * cte_cmm.read_model()(cte,cte_est) * he_cmm.read_model()(he,he_est)

            marg_prob.append((cte_est,he_est,*mp_a))
            
    return marg_prob

def write_tempest_out(tempest_out,filename):
    rep=inner_reduce(str_comb("\n"),mapL(lambda line : inner_reduce(str_comb(","),line),tempest_out))
    
    with open(filename,"w") as tf:
        print(f"writing to {filename}")
        tf.write("cte_est,he_est,action0,action1,action2\n"+rep)

        
def direct(args):
    tempest_out=parse_tempest(args.tempest_file)
    write_tempest_out(tempest_out,args.dest_file)
    
def confusion(args):
    tempest_out=parse_tempest(args.tempest_file)
    marg_prob=true_to_est_by_marginal(args.cte_file,args.he_file,tempest_out)
    final_prob=marg_prob

    # take worst case estimate of safety between direct or confusion analysis
    if args.worst_case:
        final_prob=[(to[0],to[1],*tuple(min(to_a,mp_a) for to_a,mp_a in zip(to[2:],mp[2:]))) for to,mp in zip(tempest_out,marg_prob)]

    write_tempest_out(final_prob,args.dest_file)
    
def main():
    parser = argparse.ArgumentParser(description="CLI for extracting tempest probabilities")
    subparsers = parser.add_subparsers(dest="command",help="Available commands")
    
    def add_tf(_parser):
        _parser.add_argument("--tempest_file","-tf",required=True,type=str)

    def add_dest(_parser):
        _parser.add_argument("--dest_file","-df",required=True,type=str)
        
    direct_parser=subparsers.add_parser("direct",help="directly extract Tempest data")
    direct_parser.set_defaults(func=direct)
    add_tf(direct_parser)
    add_dest(direct_parser)

    confusion_parser=subparsers.add_parser("confusion",help="include confusion matrix model for Tempest predictions")
    confusion_parser.set_defaults(func=confusion)
    add_tf(confusion_parser)
    add_dest(confusion_parser)
    confusion_parser.add_argument("--cte_file","-cte",required=True,type=str)
    confusion_parser.add_argument("--he_file","-he",required=True,type=str)
    confusion_parser.add_argument("--worst_case",action=argparse.BooleanOptionalAction)
    
    args=parser.parse_args()

    # print(args)
    if hasattr(args,"func"):
        args.func(args)
    else:
        parser.print_help()
        
if __name__=="__main__":
    main()
