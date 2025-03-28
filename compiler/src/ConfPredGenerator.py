# conformal prediction csv generator
from Util import *
import random
import numpy as np

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

def encode_woven(n,val):
    sv = val-n//2
    return int(abs(sv)*2-(1 if sv<0 else 0))

def one_hot_woven(n,one_hot):
    woven_one_hot=[0]*n
    for i in range(n):
        woven_one_hot[encode_woven(n,i)]=one_hot[i]
    return woven_one_hot
        
def binomial_sample_one_hot(n,p,size_group,size_sample):
    sample = [set(np.random.binomial(n-1,p,size=size_group)) for i in range(size_sample)]
    sample_one_hot = [tuple(1 if (x in group) else 0 for x in range(n)) for group in sample]
    woven_sample = mapL(lambda x : one_hot_woven(n,x),sample_one_hot)
    return woven_sample

def normal_sample_one_hot(n,mean,std_dev,size_group,size_sample):
    sample = [set(list(map(round,np.random.normal(loc=mean,scale=std_dev,size=n)))) for i in range(size_sample)]
    sample_one_hot = [tuple(1 if (x in group) else 0 for x in range(n)) for group in sample]
    woven_sample = mapL(lambda x : one_hot_woven(n,x),sample_one_hot)
    return woven_sample

def aggregate_one_hot(n,sample):
    totals = np.zeros(2**n)
    for s in sample:
        # compiler expects big-endian encoding (n-1-i)
        s_sum = sum(2**(n-1-i)*s[i] for i in range(n))
        totals[s_sum]+=1
    return totals

def bsample_delta(n,i,bsample):
    return sum(bsample[j][encode_woven(n,i)] for j in range(len(bsample)))/len(bsample)

def generate_confpred(n,sample,epsilon=0.1,binom=False):
    cp_model=[]
    deltas=[]
    for i in range(n):
        if binom:
            bs1=binomial_sample_one_hot(n,(i+epsilon)/(n),n,sample)
            bs2=[] #binomial_sample_one_hot(n,(i+epsilon)/(n),n-1,sample)
        else:
            bs1=normal_sample_one_hot(n,i,epsilon,n,sample)
            bs2=normal_sample_one_hot(n,i,epsilon,n-1,sample)
    
        bsample=bs1+bs2
        #print(bsample)
        deltas.append(bsample_delta(n,i,bsample))
        cp_model.append(aggregate_one_hot(n,bs1+bs2))

    # shuffle cp model with weaving
    cp_model_woven=[0]*n
    for i in range(n):
        cp_model_woven[encode_woven(n,i)]=cp_model[i]
        
    return mapL(lambda row:mapL(int,row),cp_model_woven), deltas


def gen_binom():
    print("\nGenerating Binomial Data")
    cte_cp_model,cte_deltas=generate_confpred(5,10000,epsilon=0.5,binom=True)
    he_cp_model,he_deltas=generate_confpred(3,10000,epsilon=0.5,binom=True)
    print("cte deltas:",cte_deltas)
    print("he deltas:",he_deltas)
    data_to_csv("lib/cte_confpred_gen_binom.csv",cte_cp_model)
    data_to_csv("lib/he_confpred_gen_binom.csv",he_cp_model)

def gen_normal():
    print("\nGenerating Normal Data")
    cte_cp_model,cte_deltas=generate_confpred(5,10000,epsilon=0.5,binom=False)
    he_cp_model,he_deltas=generate_confpred(3,10000,epsilon=0.5,binom=False)
    print("cte deltas:",cte_deltas)
    print("he deltas:",he_deltas)
    data_to_csv("lib/cte_confpred_gen_normal.csv",cte_cp_model)
    data_to_csv("lib/he_confpred_gen_normal.csv",he_cp_model)

if __name__=="__main__":    
    gen_binom()
    gen_normal()
