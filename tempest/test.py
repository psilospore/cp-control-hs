import pycarl

from utils import *

prism_path='taxinet_Boeing5bins_perfect_shielding.pm'
prism_file='./system_models/taxinet_Boeing5bins_perfect_shielding.pm'
formula_0='Pmax=? [G crash=0]'
formula_1='Pmax=? [G he>-1]'
storm_model=TaxiNetShieldHandler(prism_path, formula_0, shield_value=0.0, prism_file=prism_file)
storm_model.create_shield()

act_dict=storm_model.action_dictionary

i=0
max_i=10

for key in act_dict:
	print(key, act_dict[key])
# 	i+=1
# 	if i>max_i:
# 		break

# print(storm_model.action_dictionary)
