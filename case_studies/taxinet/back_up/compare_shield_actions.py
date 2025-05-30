import numpy as np
import matplotlib.pyplot as plt
import distinctipy
import os

def getResults(filename, N_vals):
    with open(filename) as f:
        lines=f.readlines()[1:]
    lines=[line.strip().split('\t') for line in lines if int(line.strip().split('\t')[0]) in N_vals]
    lines=[[int(n), vals] for [n, vals] in lines]

    results={}
    for line in lines:
        res=line[1][2:-2].split('), (')
        results[line[0]]=np.array([[val_str[1:-1].split(',')[0], val_str[1:-1].split(',')[1]] for val_str in res], dtype=float)
    return results 

def plotFront(results, ax_front, N, colour, marker=0):
    markers=['.', 'v', '3', 'X']
    vals=results[N]
    pareto_front=ax_front.scatter(vals[:,0], vals[:,1], color=colour, marker=markers[marker], s=70)
    return pareto_front

def plotSafe(results, ax_safe, colour, N_vals, style='-'):
	vals_unsafe=1-np.array([np.max(results[N][:,0]) for N in results])
	unsafe_prob_plot=ax_safe.plot(N_vals, vals_unsafe, color=colour, linestyle=style)
	return unsafe_prob_plot

plt.rcParams.update({"text.usetex": True})
fig=plt.figure()
gs=fig.add_gridspec(2,3)
ax_front_10=fig.add_subplot(gs[0,0])
ax_front_20=fig.add_subplot(gs[0,1])
ax_front_30=fig.add_subplot(gs[0,2])

ax_unsafe=fig.add_subplot(gs[1,:])
ax_unsafe_zoom=ax_unsafe.inset_axes([0.6, 0.25, 0.35, 0.35])

colours=distinctipy.get_colors(25)
marker_size=80

## Old generated
N_vals=[5,10,15,20,25,30]

prism_old_output_dir='prism_output'

files=os.listdir(prism_old_output_dir)
files.sort()
# file='conf95_af7_new_def_act_results.txt'
ind=0

## Plot 
plots={}
for file in files:
    if 'def_act_results.txt' in file:
        filename=f'{prism_old_output_dir}/{file}'
        colour=colours[ind]
        ind+=1
        results=getResults(filename, N_vals)
        pareto_front=plotFront(results, ax_front_10, 10, colour)
        plotFront(results, ax_front_20, 20, colour)
        plotFront(results, ax_front_30, 30, colour)
        plotSafe(results, ax_unsafe, colour, N_vals)
        plotSafe(results, ax_unsafe_zoom, colour, N_vals)
        plots[file]=pareto_front

legend_list=[]
for plot in plots:
	label=plot.split('_')[0]
	plots[plot].set_label(label)
	legend_list.append(plots[plot])

ax_front_legend_conf=ax_front_10.legend(handles=legend_list, bbox_to_anchor=(0., 0.45), loc='lower left')#, bbox_transform=fig.transFigure)
# loc='center left')

pareto_old_dummy=ax_front_10.scatter([],[], color=[0,0,0],s=70, marker='.', label='Using compiler')
pareto_new_dummy=ax_front_10.scatter([],[], color=[0,0,0],s=70, marker='X', label='Updated approach')
ax_front_legend_data=ax_front_10.legend(handles=[pareto_old_dummy, pareto_new_dummy], bbox_to_anchor=(0., 0.45), loc='upper left')
ax_front_10.add_artist(ax_front_legend_conf)
## New generated
prism_new_output_dir='../results/prism_output'
files=os.listdir(prism_new_output_dir)
files.sort()
ind=0

for file in files:
    if 'def_act_results.txt' in file:
        filename=f'{prism_new_output_dir}/{file}'
        colour=colours[ind]
        ind+=1
        results=getResults(filename, N_vals)
        pareto_front=plotFront(results, ax_front_10, 10, colour, marker=3)
        plotFront(results, ax_front_20, 20, colour, marker=3)
        plotFront(results, ax_front_30, 30, colour, marker=3)
        plotSafe(results, ax_unsafe, colour, N_vals, style='--')
        plotSafe(results, ax_unsafe_zoom, colour, N_vals, style='--')
        plots[file]=pareto_front
ax_unsafe_zoom.set_xlim([25,30.05])
ax_unsafe_zoom.set_ylim([-0.00001, 0.0005])
safe_old_dummy=ax_unsafe.plot([],[], color=[0,0,0], label='Using compiler')
safe_new_dummy=ax_unsafe.plot([],[], color=[0,0,0], linestyle='--', label='Updated approach')
ax_unsafe.legend(bbox_to_anchor=(0.2,0.8), loc='upper left')

ax_front_10.set_title(r'$N$=10')
ax_front_20.set_title(r'$N$=20')
ax_front_30.set_title(r'$N$=30')
ax_front_10.set_xlabel(r'Probabilty of crashing')
ax_front_20.set_xlabel(r'Probabilty of crashing')
ax_front_30.set_xlabel(r'Probabilty of crashing')
ax_front_10.set_ylabel(r'Probabilty of using default controller')
ax_unsafe.set_title(r'Safety of agent varying $N$')
ax_unsafe.set_xlabel(r'$N$')
ax_unsafe.set_ylabel('Minimum probability of not crashing')
plt.show()
