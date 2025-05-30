import numpy as np
import matplotlib.pyplot as plt
import os
import distinctipy

colours=distinctipy.get_colors(10)

dir_out='shielded_models/'
files=os.listdir(dir_out)

fig, ax_crash=plt.subplots()
ax_stuck=ax_crash.twinx()

i=0

for file in files:
	if 'acc' in file and '.pm' in file:
		values=[]
		with open(dir_out+file) as f:
			lines=f.readlines()
		lines=[line.strip() for line in lines]
		cte_lines_start=lines.index('// Perceiver (CTE)')+1
		cte_lines_end=lines.index('// Perceiver (HE)')
		cte_lines=lines[cte_lines_start:cte_lines_end]

		cte_sets_distribution={}
		cte_sets_exists=[]
		for line in cte_lines:
			if len(line)>0:
				transition_split=line.split('->')
				true_state=transition_split[0].split(' ')[1].split('=')[1]
				transition_sets=transition_split[1].split('+')
				cte_sets_distribution[true_state]=[]
				for t_s in transition_sets:
					prob_state=t_s.split(':')
					p=prob_state[0]
					state_set=''
					for s in prob_state[1].split('&'):
						if not 'pc' in s:
							state_set+=s.strip().split('=')[-1][:-1]
					cte_sets_exists.append(state_set)
					cte_sets_distribution[true_state].append(state_set)
		
		he_lines_start=lines.index('// Perceiver (HE)')+1
		he_lines_end=lines.index('// Controller')
		he_lines=lines[he_lines_start:he_lines_end]
		he_sets_distribution={}
		he_sets_exists=[]
		for line in he_lines:
			if len(line)>0:
				transition_split=line.split('->')
				true_state=transition_split[0].split(' ')[1].split('=')[1]
				transition_sets=transition_split[1].split('+')
				he_sets_distribution[true_state]=[]
				for t_s in transition_sets:
					prob_state=t_s.split(':')
					p=prob_state[0]
					state_set=''
					for s in prob_state[1].split('&'):
						if not 'pc' in s:
							state_set+=s.strip().split('=')[-1][:-1]
					he_sets_exists.append(state_set)
					he_sets_distribution[true_state].append(state_set)
		# print(file)
		# print(he_sets_distribution)
		cte_he_exists=[]
		for cte in cte_sets_exists:
			for he in he_sets_exists:
				cte_he_exists.append(cte+he)
		print(cte_he_exists)
		ind=lines.index('// Controller')+1
		while lines[ind]!='// Default Controller':
			check_line=lines[ind]
		    # [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
			state=check_line.split('->')[0]
			set_state=''
			for s in state.split('&')[:-1]:
		  		set_state+=s.split('=')[1].strip()
			if set_state not in cte_he_exists:
				lines.remove(check_line)
			else:
				ind+=1
		print(file)
		filename=file.split('_')[-2]
		if 'DefAct' in file:
			filename+='_defact'
		filename+='.pm'
		with open(dir_out+filename, 'w') as outfile:
			for l in lines:
				outfile.write(l+'\n')
