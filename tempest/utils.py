import stormpy
import stormpy.core
import stormpy.simulator

import stormpy.shields
import stormpy.logic

import stormpy.examples
import stormpy.examples.files

from enum import Enum
from abc import ABC

from PIL import Image, ImageDraw

import re
import sys
import tempfile, datetime, shutil
import numpy as np

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

class ShieldingConfig(Enum):
    Training = 'training'
    Evaluation = 'evaluation'
    Disabled = 'none'
    Full = 'full'

    def __str__(self) -> str:
        return self.value

def shield_needed(shielding):
    return shielding in [ShieldingConfig.Training, ShieldingConfig.Evaluation, ShieldingConfig.Full]

def shielded_evaluation(shielding):
    return shielding in [ShieldingConfig.Evaluation, ShieldingConfig.Full]

def shielded_training(shielding):
    return shielding in [ShieldingConfig.Training, ShieldingConfig.Full]

class ShieldHandler(ABC):
    def __init__(self) -> None:
        pass
    def create_shield(self, **kwargs) -> dict:
        pass

class TaxiNetShieldHandler(ShieldHandler):
    def __init__(self, prism_path, formula, prism_config=None, shield_value=0.9, shield_comparison='absolute', nocleanup=False, prism_file=None) -> None:
        self.tmp_dir_name = f"shielding_files_{datetime.datetime.now().strftime('%Y%m%dT%H%M%S')}_{next(tempfile._get_candidate_names())}"
        os.mkdir(self.tmp_dir_name)
        self.prism_path = self.tmp_dir_name + "/" + prism_path
        self.prism_config = prism_config
        self.prism_file = prism_file
        self.action_dictionary = None

        self.formula = formula
        shield_comparison = stormpy.logic.ShieldComparison.ABSOLUTE if shield_comparison == "absolute" else stormpy.logic.ShieldComparison.RELATIVE
        self.shield_expression = stormpy.logic.ShieldExpression(stormpy.logic.ShieldingType.PRE_SAFETY, shield_comparison, shield_value)
        # self.shield_expression = stormpy.logic.ShieldExpression(stormpy.logic.ShieldingType.POST_SAFETY, shield_comparison, shield_value)

        self.nocleanup = nocleanup
        
    def __del__(self):
        return
        # if not self.nocleanup:
        #     shutil.rmtree(self.tmp_dir_name)

    def __create_prism(self):
        if self.prism_file is not None:
            print(self.prism_file)
            print(self.prism_path)
            shutil.copyfile(self.prism_file, self.prism_path)
            return
        if self.prism_config is None:
            result = os.system(F"{self.grid_to_prism_binary} -i {self.grid_file} -o {self.prism_path}")
        else:
            result = os.system(F"{self.grid_to_prism_binary} -i {self.grid_file} -o {self.prism_path} -c {self.prism_config}")

        assert result == 0, "Prism file could not be generated"


    def __create_shield_dict(self):
        program = stormpy.parse_prism_program(self.prism_path)

        formulas = stormpy.parse_properties_for_prism_program(self.formula, program)
        options = stormpy.BuilderOptions([p.raw_formula for p in formulas])
        options.set_build_state_valuations(True)
        options.set_build_choice_labels(True)
        options.set_build_all_labels()


        print(f"LOG: Starting with explicit model creation...")
        tic()
        model=stormpy.build_sparse_model_with_options(program, options)
        toc()

        print(f"LOG: Starting with model checking...")
        tic()
        result = stormpy.model_checking(model, formulas[0], extract_scheduler=True, shield_expression=self.shield_expression)
        toc()
        print()
        assert result.has_shield
        shield = result.shield
        action_dictionary = dict()
        shield_scheduler = shield.construct()
        state_valuations = model.state_valuations
        choice_labeling = model.choice_labeling

        if self.nocleanup:
            stormpy.shields.export_shield(model, shield, self.tmp_dir_name + "/shield")

        print(f"LOG: Starting to translate shield...")
        tic()
        for stateID in model.states:
            choice = shield_scheduler.get_choice(stateID)
            choices = choice.choice_map
            state_valuation = state_valuations.get_string(stateID)
            # print(re.findall(r'(-?[_a-zA-Z0-9]+=-?[a-zA-Z0-9]+)', state_valuation))
            states=dict(re.findall(r'(-?[_a-zA-Z0-9]+)=(-?[a-zA-Z0-9]+)', state_valuation))
            # if True:
            # if states['pc']=='3':
            if states['pc']=='3' and states['k']=='1':
                key=''
                for state in states:
                    key+="{0}={1} ".format(state, states[state])
                action_dictionary[key]=([choice_labeling.get_labels_of_choice(model.get_choice_index(stateID, choice[1])) for choice in choices], choices)
        print("Size of dictionary: ", len(action_dictionary))
        # print(action_dictionary)
        self.action_dictionary = action_dictionary

        # for stateID in model.states:
        #     state_valuation = state_valuations.get_string(stateID)
        #     states=dict(re.findall(r'(-?[_a-zA-Z0-9]+)=(-?[a-zA-Z0-9]+)', state_valuation))
        #     key=''
        #     for state in states:
        #         key+="{0}={1} ".format(state, states[state])
        #     choices = shield_scheduler.get_choice(stateID)
        #     choice_list=[choice_labeling.get_labels_of_choice(model.get_choice_index(stateID, choice[1])) for choice in choices.choice_map]
        #     print(F"Allowed choices in state {key}, are {choice_list} ")

        # Remove shielding_files_* immediatelly, only to remove clutter for the demo
        if not self.nocleanup:
            shutil.rmtree(self.tmp_dir_name)
        # return action_dictionary

    def create_shield(self, **kwargs):
        if self.action_dictionary is not None:
            #print("Returning already calculated shield")
            return self.action_dictionary
            
        # env = kwargs["env"]
        # self.__export_grid_to_text(env)
        self.__create_prism()
        # print("Computing new shield")
        return self.__create_shield_dict()