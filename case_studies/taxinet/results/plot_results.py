import numpy as np
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
from matplotlib.ticker import FixedLocator, NullFormatter
import os
import distinctipy


def forward(a):
    a = np.deg2rad(a)
    return np.rad2deg(np.log(np.abs(np.tan(a) + 1.0 / np.cos(a))))
def inverse(a):
    a = np.deg2rad(a)
    return np.rad2deg(np.arctan(np.sinh(a)))

def plotFront(filename, ax_fronts, ax_safe, N_vals, colour):
    with open(filename) as f:
        lines=f.readlines()[1:]
    lines=[line.strip().split('\t') for line in lines if int(line.strip().split('\t')[0]) in N_vals]
    lines=[[int(n), vals] for [n, vals] in lines]

    results={}
    for line in lines:
        res=line[1][2:-2].split('), (')
        results[line[0]]=np.array([[val_str[1:-1].split(',')[0], val_str[1:-1].split(',')[1]] for val_str in res], dtype=float)

    front_inds=np.arange(len(results))

    markers=['.', 'v', '3', 'X', 'square']

    ind=0
    for N in results:
        vals=np.array(results[N])
        ax_fronts.scatter(vals[:,0], vals[:,1], color=colour, marker=markers[ind], s=70)
        ind+=1
    vals_unsafe=1-np.array([np.max(results[N][:,0]) for N in results])
    ax_safe.plot(N_vals, vals_unsafe, color=colour)

N_vals=[5,10,15,25]

prism_output_dir='prism_output'

fig=plt.figure()
gs=fig.add_gridspec(2,2)

ax_fronts=fig.add_subplot(gs[0,:])
ax_unsafe=fig.add_subplot(gs[1,:])

colours=distinctipy.get_colors(10)
plt.rcParams['font.size']=20

files=os.listdir(prism_output_dir)
# file='conf95_af7_new_def_act_results.txt'
ind=0

## Plot 
for file in files:
    if 'def_act_results.txt' in file:
        print(file)
        filename=f'{prism_output_dir}/{file}'
        colour=colours[ind]
        ind+=1
        plotFront(filename, ax_fronts, ax_unsafe, N_vals, colour) 

plt.xlabel('Probability of crashing')
plt.ylabel('Average times of no safe actions')

# ax_fronts.set_xscale('function', functions=(forward, inverse))
# ax_fronts.set_xlim([-0.01,1.01])
# ax_fronts.xaxis.set_minor_formatter(NullFormatter())
# ax_fronts.xaxis.set_major_locator(FixedLocator(np.arange(0, 1.0, 0.1)))
ax_fronts.set_xscale('log', base=2)
# l_00001=np.log(0.0001/(1-0.0001))
# l_05=np.log(0.5/(1-0.5))
# l_999=np.log(0.999/(1-0.999))
# print([l_00001, l_05, l_999])
# ax_fronts.set_xticks([l_00001, l_05, l_999], labels=['0', '0.5', '1.0'])
# ax_fronts.set_yscale('function', functions=(forward, inverse))
# ax_fronts.set_ylim([0, 1.5])
# ax_fronts.yaxis.set_minor_formatter(NullFormatter())
# ax_fronts.yaxis.set_major_locator(FixedLocator(np.arange(0, 1.5, 0.5)))
plt.legend(loc='upper left')
plt.show()