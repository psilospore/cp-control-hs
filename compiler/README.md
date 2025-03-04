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
  * components also define fail states as [String]
	
* LoopingStateMachine (LoopingStateMachine.py)
  * builds simple state machine from PrismComponents
  * assigns (non negative) pc values to each component
  * assigns negative pc values to fail states (so fail condition can always be `pc < 0` regardless of number of components)
  * generates PRISM file from component design in `./bin`
  
### Examples

* All examples change state encoding from (0,1,2,3,4,...) to (0,1,-1,2,-2,...) 
    * this decreases dynamics logic (drastically) but increases the state space slightly
	* also requires extra failure check in dynamics (dyn_fail) to satisfy PRISM (but we can verify this occurs with probability 0)

* TaxiPLSM.py
  * allows two perception models:
    * Confusion Matrix (ConfMat) models `State -> StateEst` (same as CAV'23 paper but with different data)
	* Correlated Error (CorrErr) models `Previous Error, State -> StateEst` 
	
* Dead Reckoning (TaxiPLSM_DR.py)
  * increases known states to `(cte_est,he_est)**m`
  * uses simple shield synthesis method to design controller (ShieldBuilder.py)
  * decreases controller logic with ComponentMinimizer.py
	

* See `./bin` for examples of generated prism files 
  * WARNING: many of these were generated with previous designs, so they do not match current implementations
  
* `./lib` provides test data to build probabilistic models (most of these were created by DataGenerator.py)

### Integration

* Prism CLI (PrismExec.py)
  * provides wrapper for `prism` CLI in python
  * used in CorrExperiment.py

* Tempest
  * TODO


### Shielded Conformal Preduction Model (src/TaxiShieldedConfPred.py)

* builds model to (roughly) fit design specs of project
* generates mpd prism file

**Shielded Controller:**

* takes tempest generated safety estimates as CSV (_-\-tempest_pred_)
* csv format: cte\_est: [0..4], he\_est: [0..2], action0: float, action1: float, action2: float
* see **lib/tempest_test** for an example
* generates nondeterministic controller based on shielding logic (filters actions by probibility with _-\-action\_filter_)

**Conformal Prediction Percepter:**

* takes conf pred generated model of state->state\_est**num\_est (_-\-conformal\_pred\_cte_,_-\-conformal\_pred\_he_)
* controlled by number of estimates (_-\-num\_est_)
* csv format expects specific order of state/state\_est enumeration (see warnings when run)
* see **lib/{cte,he}\_confpred\_toy.csv** for examples

**TODO**

* add default choice for empty shields
* allow empty conformal prediction estimates (when estimate set is less than num\_est) e.g. allow (cte\_est,he\_est) = (-1,-1)



