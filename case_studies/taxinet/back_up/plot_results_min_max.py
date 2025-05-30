import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import distinctipy
import os


fig, ax_crash = plt.subplots()
ax_stuck = ax_crash.twinx()  # instantiate a second Axes that shares the same x-axis
matplotlib.rcParams["errorbar.capsize"]

cols_no=3
colours=distinctipy.get_colors(cols_no)



def plotResults(N, props_no, output_file, colour, lw, results_label):
	with open(output_file) as f:
		vals=np.zeros([N, props_no])
		vals_lines=f.readlines()
		block_amount=N+3 ## Prop-params/results-new line
		for i in np.arange(props_no):
			prop_results=vals_lines[block_amount*i+2:block_amount*(i+1)-1]
			vals[:,i]=np.array([float(r.split('\t')[-1].strip()) for r in prop_results])
	## Plot vals
	## Acquire average between min and max
	T=np.arange(N)+1
	prop_crash=(vals[:,0]+vals[:,1])/2.0
	error_crash=abs((vals[:,0]-vals[:,1])/2.0)
	prop_stuck=(vals[:,2]+vals[:,3])/2.0
	error_stuck=abs((vals[:,2]-vals[:,3])/2.0)
	cap_size=10
	ax_crash.errorbar(T, prop_crash, yerr=[error_crash], c=colour, linewidth=lw, label=results_label, capsize=cap_size, capthick=lw)
	ax_stuck.errorbar(T, prop_stuck, yerr=[error_stuck], c=colour, linewidth=lw, linestyle='--', capsize=cap_size, capthick=lw)

N=15
props_no=4
output_dir_path='prism_output/'

files=os.listdir('prism_output')
labels=['Confidence: .95', 'Confidence: .99', 'Confidence: .995']
lws=[3, 4, 2]


for (file, l, colour, lw) in zip(files, labels, colours, lws):
	plotResults(N, props_no, output_dir_path+file, colour, lw, l)

ax_crash.legend()
plt.show()