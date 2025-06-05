import numpy as np
import sys 

def extractData(d_str):
    d_extract=[]
    if '[' in d_str:
        d_val=d_str.split('[(')[1].split(')]')[0]
        d_val=d_val.split('), (')
        for dd in d_val:
            dd_list=dd.split(',')
            d_extract.append([float(ddd) for ddd in dd_list])
    else:
        d_extract=float(d_str)
    return d_extract

def loadData(filename, N):
    with open(filename) as f:
        lines=f.readlines()
    data_dict={}
    index=0
    while index+1+N<len(lines):
        data_str=lines[index+2:index+2+N]
        data=[[int(d.strip().split('\t')[0]), extractData(d.strip().split('\t')[1])] for d in data_str]
        data_dict[lines[index].strip()]=data
        index+=(N+3)
    return data_dict

def loadPropResultsData(filename, N, prop):
    results_dict=loadData(filename, N)
    try:
        prop_results=results_dict[prop]
    except KeyError:
        print(f"Property {prop} is not in results. Properties that have results are:")
        for p in results_dict:
            print(f"\t - {p}")
        sys.exit()
    else:
        return(prop_results)