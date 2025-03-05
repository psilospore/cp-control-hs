# conformal prediction csv generator
from Util import *
import random

def toy_data(low,high,n_est):
    diff=high-low+1
    data=[]
    for i in range(diff+1):
        row_len=2**diff # diff**n_est
        row=[1]*row_len
        # for i in range(diff**n_est):
        #     row.append(random.random())
        data.append(row)
    # print(data)
    return data

def data_to_csv(filename,data):
    # data_rep=inner_reduce(str_comb("\n"),
    data_rep=inner_reduce(str_comb("\n"),list(map(lambda d : inner_reduce(str_comb(","),list(map(lambda x:f"{x}",d))),data)))
    # print(data_rep)
    with open(filename,"w") as f:
        f.write(data_rep)
        f.write("\n")
    print(f'wrote to {filename}')


if __name__=="__main__":
    data_to_csv("lib/cte_confpred_toy.csv",toy_data(0,4,2))
    data_to_csv("lib/he_confpred_toy.csv",toy_data(0,2,2))
