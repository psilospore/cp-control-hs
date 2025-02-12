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

**This project was built quickly and with the use of AI. It includes many bugs and regrettable design decisions. Don't expect functions to work outside the narrow window of their use case, if at all. Contributions are welcomed.**
