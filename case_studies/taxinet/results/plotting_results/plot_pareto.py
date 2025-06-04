import numpy as np
import matplotlib.pyplot as plt
import distinctipy
import os
from utils import loadData

markers=['3', 'v', '.', 'X']
marker_sizes=[130*1.5, 90*1.1, 80*1.5, 120*1.1]

baseline_min_safety=np.loadtxt('../prism_output/baseline_res_processed.txt')
baseline_min_safety[:,1]=1-baseline_min_safety[:,1]

baseline_with_shield_min_safety=np.loadtxt('../prism_output/baseline_with_shielding_res_processed.txt')
baseline_with_shield_min_safety[:,1]=1-baseline_with_shield_min_safety[:,1]

def forward(val):
    # return np.sqrt(val)
    return val**2

def backward(val):
    return val**(0.5)

def forwardY(val):
    # return np.sqrt(val)
    return val**(0.5)

def backwardY(val):
    return val**(2)

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
    z_order=[100, 80, 40, 60]
    vals=results[N]
    pareto_front=ax_front.scatter(vals[:,0], vals[:,1], color=colour, marker=markers[marker], s=marker_sizes[marker], zorder=z_order[marker])
    return pareto_front

def plotSafe(results, ax_safe, colour, N_vals, style='-'):
	vals_unsafe=1-np.array([np.max(results[N][:,0]) for N in results])
	unsafe_prob_plot=ax_safe.plot(N_vals, vals_unsafe, color=colour, linestyle=style)
	return unsafe_prob_plot

plt.rcParams.update({"text.usetex": True})
plt.rcParams['font.size']=15
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
N_vals=np.arange(2,31)
N=30
## Plot
plots={}

## New generated
prism_new_output_dir='../prism_output'
files=os.listdir(prism_new_output_dir)
files.sort()
ind=0

conf_dict={'conf95': 0, 'conf99': 1, 'conf995':2}
shield_thresh_dict={'af6': [0, 0.65], 'af7': [1, 0.9], 'af8': [2, 0.8], 'af9': [3, 1.0]}
linestyle_dict={'af6': '-', 'af7': '--', 'af8': ':', 'af9': '-.'}

for file in files:
    if 'def_act_results.txt' in file:
        filename=f'{prism_new_output_dir}/{file}'
        loadData(filename, N)
        sys.exit()
        file_components=file.split('_')
        conf_str=file_components[0]
        colour=colours[conf_dict[conf_str]]

        shield_thresh_str=file_components[1]
        shield_thresh_vis=shield_thresh_dict[shield_thresh_str]
        # ind+=1
        results=getResults(filename, N_vals)
        pareto_front=plotFront(results, ax_front_10, 10, [c*shield_thresh_vis[1] for c in colour], marker=shield_thresh_vis[0])
        plotFront(results, ax_front_20, 20, [c*shield_thresh_vis[1] for c in colour], marker=shield_thresh_vis[0])
        plotFront(results, ax_front_30, 30, [c*shield_thresh_vis[1] for c in colour], marker=shield_thresh_vis[0])
        plotSafe(results, ax_unsafe, colour, N_vals, style=linestyle_dict[file_components[1]])
        plotSafe(results, ax_unsafe_zoom, colour, N_vals, style=linestyle_dict[file_components[1]])
        if conf_str not in plots:
            plots[conf_str]=ax_front_10.scatter([],[],color=colour,s=120)

legend_list=[]
for plot in plots:
  conf_number=plot.split('_')[0][4:]
  label=f'0.{conf_number}'
  plots[plot].set_label(label)
  legend_list.append(plots[plot])

ax_front_legend_conf=ax_front_10.legend(handles=legend_list, bbox_to_anchor=(0., 0.6), loc='lower left')#, bbox_transform=fig.transFigure)
# loc='center left')


dummy_handles=[]
for key in sorted(shield_thresh_dict):
    dummy_handles.append(ax_front_10.scatter([],[], color=[0,0,0],s=120, marker=markers[shield_thresh_dict[key][0]], label=f'0.{key[-1]}'))

ax_front_legend_data=ax_front_10.legend(handles=dummy_handles, bbox_to_anchor=(0., 0.6), loc='upper left')
ax_front_10.add_artist(ax_front_legend_conf)

ax_unsafe_zoom.set_xlim([25,30.05])
ax_unsafe_zoom.set_ylim([-0.00001, 0.0005])
# safe_old_dummy=ax_unsafe.plot([],[], color=[0,0,0], label='Using compiler')
# safe_new_dummy=ax_unsafe.plot([],[], color=[0,0,0], linestyle='--', label='Updated approach')
ax_unsafe.legend(bbox_to_anchor=(0.2,0.8), loc='upper left')

ax_unsafe.plot(baseline_min_safety[:,0], baseline_min_safety[:,1], c=[0,0,0], linestyle='--')
ax_unsafe.plot(baseline_with_shield_min_safety[:,0], baseline_with_shield_min_safety[:,1], c=[0,0,0], linestyle='-')

ax_front_10.set_title(r'$N$=10')
ax_front_20.set_title(r'$N$=20')
ax_front_30.set_title(r'$N$=30')
ax_front_10.set_xlabel(r'Probabilty of crashing')
ax_front_20.set_xlabel(r'Probabilty of crashing')
ax_front_30.set_xlabel(r'Probabilty of crashing')
ax_front_10.set_ylabel(r'Average counts of using the default controller')

# ax_front_10.set_xscale('asinh', linear_width=0.00001, base=20)
# ax_front_10.set_yscale('log')
# ax_front_20.set_yscale('log')
# ax_front_30.set_yscale('log')
# ax_front_20.set_xscale('log', base=50.0)
ax_front_10.set_xscale('function', functions=(forward, backward))
ax_front_20.set_xscale('function', functions=(forward, backward))
ax_front_30.set_xscale('function', functions=(forward, backward))

# ax_front_10.set_yscale('function', functions=(forwardY, backwardY))
# ax_front_20.set_yscale('function', functions=(forwardY, backwardY))
# ax_front_30.set_yscale('function', functions=(forwardY, backwardY))

ax_unsafe.set_title(r'Safety of agent varying $N$')
ax_unsafe.set_xlabel(r'$N$')
ax_unsafe.set_ylabel('Minimum probability of not crashing')
plt.show()
