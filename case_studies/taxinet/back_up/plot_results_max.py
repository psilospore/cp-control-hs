import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import distinctipy
import os


fig, ax_crash = plt.subplots()
ax_stuck = ax_crash.twinx()  # instantiate a second Axes that shares the same x-axis
matplotlib.rcParams["errorbar.capsize"]
matplotlib.rcParams["font.size"]=15

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
	T=np.arange(N)+1
	## Only consider max (worst case)
	prop_crash=1-vals[:,1] ## 1-p is prob of being safe
	prop_stuck=vals[:,3]
	cap_size=10
	ax_crash.plot(T, prop_crash, c=colour, linewidth=lw, label=results_label)
	ax_stuck.plot(T, prop_stuck, c=colour, linewidth=lw, linestyle='--')

N=100
props_no=4
output_dir_path='prism_output/'

files=os.listdir('prism_output')
labels=['Confidence: .95', 'Confidence: .99', 'Confidence: .995']
lws=[2, 2.5, 1.5]


for (file, l, colour, lw) in zip(files, labels, colours, lws):
	plotResults(N, props_no, output_dir_path+file, colour, lw, l)

ax_crash.legend()
# x_ticks=np.arange(N)+1
# ax_crash.set_xticks(x_ticks, fontsize=20)
tick_fs=15
ax_crash.tick_params(axis='x', labelsize=tick_fs)
ax_crash.tick_params(axis='y', labelsize=tick_fs)
ax_stuck.tick_params(axis='y', labelsize=tick_fs)
ax_crash.set_xlabel('Length of operation', fontsize=20)
ax_crash.set_ylabel('Probability of safe operation', fontsize=20)
ax_stuck.set_ylabel('Probability of getting stuck', fontsize=20, labelpad=20, rotation=270)
plt.show()