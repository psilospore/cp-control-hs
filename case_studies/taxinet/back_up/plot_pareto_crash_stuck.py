import numpy as np
import matplotlib.pyplot as plt
import os
import distinctipy

colours=distinctipy.get_colors(10)

dir_out='prism_output/'
files=os.listdir(dir_out)

fig, ax_crash=plt.subplots()
ax_stuck=ax_crash.twinx()

i=0

for file in files:
	if 'defact' in file and 'results' in file:
		values=[]
		with open(dir_out+file) as f:
			lines=f.readlines()
			for line in lines[1:-1]:
				vals=line.split('\t')[1].strip()
				values.append(vals)
			values=np.array([[float(v.split(',')[0][2:]), float(v.split(',')[1][:-2])] for v in values])
		N=np.arange(len(values))
		l=file.split('_')[0]
		print(l)
		ax_crash.plot(N, values[:,0], label=file.split('_')[0], c=colours[i])
		ax_stuck.plot(N, values[:,1], c=colours[i], linestyle='--')
		i+=1
ax_crash.legend()
plt.show()