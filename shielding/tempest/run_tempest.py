import stormpy
import stormpy.core
import stormpy.simulator

import stormpy.shields
import stormpy.logic

import stormpy.examples
import stormpy.examples.files

import re
import sys
import tempfile, datetime, shutil

import os
import time

import argparse

def tic():
    #Homemade version of matlab tic and toc functions: https://stackoverflow.com/a/18903019
    global startTime_for_tictoc
    startTime_for_tictoc = time.time()

def toc():
    if 'startTime_for_tictoc' in globals():
        print("Elapsed time is " + str(time.time() - startTime_for_tictoc) + " seconds.")
    else:
        print("Toc: start time not set")

def delete(tmp_dir_name):
    shutil.rmtree(tmp_dir_name)
    

nocleanup = True
tmp_dir_name = f"shielding_files_{datetime.datetime.now().strftime('%Y%m%dT%H%M%S')}_{next(tempfile._get_candidate_names())}"
os.mkdir(tmp_dir_name)
prism_path = tmp_dir_name + "/" + "taxinet.prism"
prism_config = None
prism_file = ""
action_dictionary = None

formula = ""
shield_comparison = "absolute"
shield_value = 0.9
shield_comparison = stormpy.logic.ShieldComparison.ABSOLUTE if shield_comparison == "absolute" else stormpy.logic.ShieldComparison.RELATIVE
shield_expression = stormpy.logic.ShieldExpression(stormpy.logic.ShieldingType.PRE_SAFETY, shield_comparison, shield_value)

print(prism_file)
print(prism_path)
shutil.copyfile(prism_file, prism_path)

def create_shield_dict():
    program = stormpy.parse_prism_program(prism_path)

    formulas = stormpy.parse_properties_for_prism_program(formula, program)
    options = stormpy.BuilderOptions([p.raw_formula for p in formulas])
    options.set_build_state_valuations(True)
    options.set_build_choice_labels(True)
    options.set_build_all_labels()
    print(f"LOG: Starting with explicit model creation...")
    tic()
    model = stormpy.build_sparse_model_with_options(program, options)
    toc()

    print(f"LOG: Starting with model checking...")
    tic()
    result = stormpy.model_checking(model, formulas[0], extract_scheduler=True, shield_expression=shield_expression)
    toc()

    assert result.has_shield
    shield = result.shield
    action_dictionary = dict()
    shield_scheduler = shield.construct()
    state_valuations = model.state_valuations
    choice_labeling = model.choice_labeling


    stormpy.shields.export_shield(model, shield, tmp_dir_name + "/shield")

    # print(f"LOG: Starting to translate shield...")
    # tic()

    # for stateID in model.states:
    #     choice = shield_scheduler.get_choice(stateID)
    #     choices = choice.choice_map

    #     state_valuation = state_valuations.get_string(stateID)

    #     ints = dict(re.findall(r'([a-zA-Z][_a-zA-Z0-9]+)=(-?[a-zA-Z0-9]+)', state_valuation))
    #     booleans = re.findall(r'(\!?)([a-zA-Z][_a-zA-Z0-9]+)[\s\t]+', state_valuation)
    #     booleans = {b[1]: False if b[0] == "!" else True for b in booleans}

    #     action_dictionary[id] = 

    # toc()
    # #print(f"{len(action_dictionary)} states in the shield")

    # Remove shielding_files_* immediatelly, only to remove clutter for the demo
    if not nocleanup:
        shutil.rmtree(tmp_dir_name)
    return action_dictionary


def create_shield():        
    print("Computing new shield")
    return create_shield_dict()
        

def expname(args):
    return f"{datetime.datetime.now().strftime('%Y%m%dT%H%M%S')}_{args.env}_{args.shielding}_{args.shield_comparison}_{args.shield_value}_{args.expname_suffix}"

def common_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument("--prism_file", default=None)
    parser.add_argument("--log_dir", default="../log_results/")
    parser.add_argument("--formula", default="Pmax=? [G !AgentIsOnLava]")
    parser.add_argument("--steps", default=20_000, type=int)
    parser.add_argument("--shield_creation_at_reset", action=argparse.BooleanOptionalAction)
    parser.add_argument("--prism_config",  default=None)
    parser.add_argument("--shield_value", default=0.9, type=float)
    parser.add_argument("--shield_comparison", default='absolute', choices=['relative', 'absolute'])
    parser.add_argument("--nocleanup", action=argparse.BooleanOptionalAction)
    parser.add_argument("--expname_suffix", default="")
    return parser
    
if __name__ == '__main__':

