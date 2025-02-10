import PrismAST as PAST
from Util import *

from functools import reduce
import subprocess

def dynamics(state,action):
    cte=state[0]
    he=state[1]

    return (cte+he+action,he+action)

def is_safe(state):
    cte=state[0]
    he=state[1]

    return cte >= -2 and cte <= 2 and he >= -1 and he <= 1

def action_set():
    return [-1,0,1]

def find_safe_actions(state):
    return list(filter(lambda a : is_safe(dynamics(state,a)), action_set()))
    

def state_space():
    return [(cte,he) for cte in range(-2,3) for he in range(-1,2)]

def enumerate_safe_action_func():
    return list(map(lambda s: (s,find_safe_actions(s)),state_space()))

# expects [cte_est,he_est]*k
# returns [action]
def controller(var_assign):
    k=len(var_assign)//2
    cte_ests=[var_assign[i][1] for i in range(k)]
    he_ests=[var_assign[i+1][1] for i in range(k)]
    
    actions=[]
    for state in zip(cte_ests,he_ests):
        actions.append(find_safe_actions(state))
        
    safe_actions = set(actions[0])
    for sas in actions:
        safe_actions.union(sas)

    cte_est=cte_ests[0]
    he_est=he_ests[0]
    if cte_est==0:
            prefered_a=-he_est
    else:
        cte_sign = int(cte_est / abs(cte_est))
        if cte_sign*he_est == -1:
            prefered_a=0
        else:
            prefered_a=-cte_sign

    if not safe_actions or prefered_a in safe_actions:
        # print("rejecting prefered")
        final_a=prefered_a
    else:
        final_a=safe_actions.pop()
    return [("a",final_a)]


