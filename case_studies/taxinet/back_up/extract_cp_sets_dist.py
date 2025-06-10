import numpy as np
import matplotlib.pyplot as plt

filename='shielded_models/ShieldedConfPred_StochDyn_acc90_conf95_af7.pm'
with open(filename) as f:
	lines=f.readlines()
	lines=[line.strip() for line in lines]
	cte_lines_start=lines.index('// Perceiver (CTE)')+1
	cte_lines_end=lines.index('// Perceiver (HE)')
	cte_lines=lines[cte_lines_start:cte_lines_end]

cp_sets_distribution={}
for line in cte_lines:
	if len(line)>0:
		transition_split=line.split('->')
		true_state=transition_split[0].split(' ')[1].split('=')[1]
		transition_sets=transition_split[1].split('+')
		cp_sets_distribution[true_state]=[]
		for t_s in transition_sets:
			prob_state=t_s.split(':')
			p=prob_state[0]
			state_set=''
			for s in prob_state[1].split(' & '):
				state_set+=s.strip().split('=')[-1][:-1]
			cp_sets_distribution[true_state].append([p,state_set])

for true_state in cp_sets_distribution:
	output='True state: {0}\n'.format(true_state)
	sets_output=''
	for s in cp_sets_distribution[true_state]:
		sets_output+=(s[1]+'  :  '+s[0]+'\n')
	sets_output+'\n'
	print(output+sets_output)
