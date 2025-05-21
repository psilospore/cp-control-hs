MODEL_PATH=shielded_models
PROPS_FILE=properties/shield_cp_props.pctl
UPPER_N=20
OUTPUT_PATH=prism_output

prism $MODEL_PATH/ShieldedConfPred_StochDyn_acc90_conf95_af70.pm $PROPS_FILE -const N=1:$UPPER_N -exportresults $OUTPUT_PATH/95_conf_results.txt
prism $MODEL_PATH/ShieldedConfPred_StochDyn_acc90_conf99_af70.pm $PROPS_FILE -const N=1:$UPPER_N -exportresults $OUTPUT_PATH/99_conf_results.txt
prism $MODEL_PATH/ShieldedConfPred_StochDyn_acc90_conf995_af70.pm $PROPS_FILE -const N=1:$UPPER_N -exportresults $OUTPUT_PATH/995_conf_results.txt