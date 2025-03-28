# Python DSL to PRISM compiler


### Prism AST (PrismAST.py)

* PrismVar
  * models PRISM variables with name, range, initial value
* PrismTrans
  * models PRISM logic as (condition: String,[(assignment: String,prob: float)])
  * does not allow non deterministic assignment (TODO)

### Control System Abstraction

* PrismComponent (PrismComponent.py)
  * models component logic with function of type: \
    (inputs: [PrismVar], outputs: [PrismVar], FailStates: [Int]) -> (pc: Int -> logic: [PrismTransition])
  * provides several methods of building components
	* directly 
	* from probabilistic model (see BayesianModel.py, ConfMatModel.py, CorrErrModel.py)
	* by enumeration over python function
  * We also provide a minimizer for components defined by enumeration (ComponentMinimizer.py)
    * requires [espresso](https://github.com/classabbyamp/espresso-logic) to work
	* this tools is still in development, we should do SMT validation of simplified logic
    * Experimental results show component minimization **increases** prism execution time (abandoning)
  * components also define fail states as [String]
	
* LoopingStateMachine (LoopingStateMachine.py)
  * builds simple state machine from PrismComponents
  * assigns (non negative) pc values to each component
  * assigns negative pc values to fail states (so fail condition can always be `pc < 0` regardless of number of components)
  * generates PRISM file from component design in `./bin/`
  

### Integration

* Prism CLI (PrismExec.py)
  * provides wrapper for `prism` CLI in python
  * example use in CorrExperiment.py

* Tempest
  * TODO


### Shielded Conformal Preduction Model (src/TaxiShieldedConfPred.py)

* builds model to (roughly) fit design specs of project
* generates mdp prism file

**Arguments**

* _-\-tempest_pred_: 
  * CSV file defining action safety properties at given state
  * Format: cte\_est: [0..4], he\_est: [0..2], action0: float, action1: float, action2: float
* _-\-action\_filter_: 
  * minimum value for an action to be considered safe
* _-\-conformal\_pred\_cte_: 
  * CSV file defining cte confusion matrix (cte,2^cte\_est -> Freq)
  * Format:
    * Rows correspond to possible cte values [0..4]
    * Columns correspond to binary representation of cte\_est set e.g.
      * row0: ('cte_est0', 0), ('cte_est1', 0), ('cte_est2', 0), ('cte_est3', 0), ('cte_est4', 0) which is equivalent to {}
      * row1: ('cte_est0', 0), ('cte_est1', 0), ('cte_est2', 0), ('cte_est3', 0), ('cte_est4', 1) which is equivalent to {cte_est=4}
      * row2: ('cte_est0', 0), ('cte_est1', 0), ('cte_est2', 0), ('cte_est3', 1), ('cte_est4', 0) which is equivalent to {cte_est=3}
      * row3: ('cte_est0', 0), ('cte_est1', 0), ('cte_est2', 0), ('cte_est3', 1), ('cte_est4', 1) which is equivalent to {cte_est=3,cte_est=4}
     * entries correspond to frequency of observation
* _-\-conformal\_pred\_he_:
  * same format as cte, but modified for he values in [0..2]

**Shielded Controller:**

* takes tempest generated safety estimates as CSV (_-\-tempest_pred_)
* see **lib/tempest_test** for an example
* generates nondeterministic controller based on shielding logic (filters actions by probibility with _-\-action\_filter_)
* current default for empty shield: choose default action (a=0) and increment no-safe-action counter (alpha)

**Conformal Prediction Percepter:**

* takes conf pred generated model of state->2^state\_{est} (_-\-conformal\_pred\_cte_,_-\-conformal\_pred\_he_)
* see **lib/{cte,he}\_confpred\_toy.csv** for examples

**Example use:**

```python3 src/TaxiShieldedConfPred.py -cpcte lib/cte_confpred_toy.csv -cphe lib/he_confpred_toy.csv -tp lib/tempest_test.csv -af 0.3 -l PS_toy1```

### Tempest Data Extractor (src/TempestExtractor.py)

Converts raw tempest data into csv format expected for the shield Shielded Conformal Preduction Model

Provides two methods for doing this:

**direct**

* Converts states in raw tempest file directly to state estimates in shield csv
* **Arguments:**
  * _-\-tempest_file_ (tf): raw tempest file
  * _-\-dest_file_ (df): destination file

**confusion**

* This accounts for state confusion using marginalization in state to state estimate conversion
* Inverting the confusion matrices from the CAV'23 paper produces $P(S | S\_{est})$
* Tempest output models $P(Safe \land A | S \land S\_{est})$
* Combining these two produces a model $P(Safe \land A | S\_{est})$ according to law of total probability ([marginalization](https://math.stackexchange.com/questions/2377816/applying-law-of-total-probability-to-conditional-probability) )
  * $P(Safe \land A | S\_{est}) = \sum_S P(Safe \land A | S \land S\_{est}) * P(S | S\_{est})$
* This will increase the estimated safety of some actions
  * _-\-worst_case_ takes minimum between **direct** and **confusion** to avoid this
* **Arguments:**
  * _-\-tempest_file_ (tf): raw tempest file
  * _-\-dest_file_ (dt): destination file
  * _-\-cte_file_ (cte): cte sample file
  * _-\-he_file_ (he): he sample file
  * _-\-worst_case_: minimum between **direct** and **confusion**
  
**Example use:**

```python3 src/TempestExtractor.py direct -tf lib/tempest_raw.txt -df lib/temp_extr_dir.csv```

```python3 src/TempestExtractor.py confusion -tf lib/tempest_raw.txt -df lib/temp_extr_conf.csv -cte lib/cte_sample.csv -he lib/he_sample.csv --worst_case```


### Conformal Prediction Sample Generation
*src/ConfPredGenerator.py*

This file provides two methods for producing toy conformal prediction data to test with the ShieldedConfPred model. 

1. **Normal:** generates a sample following a gaussian distribution. The std of the distribution may be modified by the epsilon perameter (to change accuracy of conformal prediction)


2. **Binomial:** generates sample following binomial distribution. Cannot currently be modified to change accuracy, but likely provides a better model of conf pred distribution


Files:

* *cte\_confpred\_gen\_binom.csv*
* *he\_confpred\_gen\_binom.csv*
* *cte\_confpred\_gen\_normal.csv*
* *he\_confpred\_gen\_normal.csv*

This file does not have a CLI, requires manual editing to change settings. Run ```python src/ConfPredGenerator.py``` to use.
