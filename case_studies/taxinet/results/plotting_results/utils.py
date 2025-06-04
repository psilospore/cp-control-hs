import numpy as np

def extractData(d_str):
	d_extract=[]
	if '[' in d_str:
		d_val=d_str.split('[(')[1].split(')]')[0]
		d_val=d_val.split('), (')
		for dd in d_val:
			dd_list=dd.split(',')
			d_extract.append([float(ddd) for ddd in dd_list])
	else:
		print(d_str)
		d_extract=float(d_str)
	return d_extract

def loadData(filename, N):
	with open(filename) as f:
		lines=f.readlines()
	data_dict={}
	index=0
	while index+1+N<len(lines):
		data_str=lines[index+2:index+2+N]
		print(data_str)
		data=[[int(d.strip().split('\t')[0]), extractData(d.strip().split('\t')[1])] for d in data_str]
		data_dict[lines[0]]=data
		index+=(N+3)
		print(index)
	return data_dict