import numpy as np
import os

shield_vals=np.loadtxt('shield_vals.txt')
shield_thresh=0.7

compiler_gen_model_dir='../models_from_compiler'
updated_models_dir='../cp_shielded_models'
files=os.listdir(compiler_gen_model_dir)

for file in files:
    if '.pm' in file:
        values=[]
        in_file=f'{compiler_gen_model_dir}/{file}'
        with open(in_file) as f:
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


        cte_he_exists=[]

        combined=[[cte, he] for cte in cte_sets_exists for he in he_sets_exists]

        for [cte, he] in combined:
            s_list=[]
            for i in np.arange(len(cte)):
                if cte[i]=='1':
                    for j in np.arange(len(he)):
                        if he[j]=='1':
                            s_list.append(f's_{i}{j}')
            cte_he_exists.append(s_list)

        allowable_acts=[]
        for s_list in cte_he_exists:
            a_list=[0,1,2]
            for s in s_list:
                cte=int(s[-2])
                he=int(s[-1])
                for a in a_list:
                    if shield_vals[cte*3+he, a+2]<shield_thresh:
                        a_list.remove(a)
                if len(a_list)==0:
                    break
            allowable_acts.append([s_list, a_list])
        empty_sets=np.sum([len(act)>0 for [s_list, act] in allowable_acts])
        
        transition_lines=''
        for [s_list, act_list] in allowable_acts:
            cte_ests=np.zeros(5, dtype=int)
            he_ests=np.zeros(3, dtype=int)
            for s in s_list:
                cte=s[-2]
                he=s[-1]
                cte_ests[int(cte)]=1
                he_ests[int(he)]=1
            if len(act_list)>0:
                for a in act_list:
                    transition_lines+=f' [] cte_est0={cte_ests[0]} & cte_est1={cte_ests[1]} & cte_est2={cte_ests[2]} & cte_est3={cte_ests[3]} & cte_est4={cte_ests[4]} & he_est0={he_ests[0]} & he_est1={he_ests[1]} & he_est2={he_ests[2]} & pc=2 -> (a\'={a}) & (pc\'=3) ;\n'
            else:
                transition_lines+=f'''[] cte_est0={cte_ests[0]} & cte_est1={cte_ests[1]} & cte_est2={cte_ests[2]} & cte_est3={cte_ests[3]} & cte_est4={cte_ests[4]} & he_est0={he_ests[0]} & he_est1={he_ests[1]} & he_est2={he_ests[2]} & pc=2 -> (default\'=1) & (pc\'=3) ;\n'''
        
        with open(in_file) as f:
            lines_orig=f.readlines()
            lines=[line.strip() for line in lines_orig]
            start=lines.index('// Controller')+1
            end=lines.index('// Default Controller')

        out_filename=f'{file[:-3]}_new.pm'
        out_file=f'{updated_models_dir}/{out_filename}'
        with open(out_file, 'w') as new_file:
            for line in lines_orig[:start]:
                new_file.write(line)
            new_file.write(transition_lines)
            for line in lines_orig[end:]:
                new_file.write(line)

