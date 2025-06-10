MODEL_PATH=shielded_models
PROPS_FILE=properties/crash_stuck.pctl
PROPS_DC_FILE=properties/crash_stuck_default_controller.pctl
N_START=5
N_STEP=5
UPPER_N=30
OUTPUT_PATH=prism_output

rm prism_output/*

for file in $MODEL_PATH/*; do
	filename=$(basename $file)
    echo 'Processing file:  '$filename
    defActStr='DefAct'
	if [[ $filename == *$defActStr* ]]; then
    	outFileName=${filename:39:-3}_def_act
    	prism $file $PROPS_DC_FILE -const N=$N_START:$N_STEP:$UPPER_N -exportresults $OUTPUT_PATH/${outFileName}_results.txt > $OUTPUT_PATH/${outFileName}_out.txt 
	else
		outFileName=${filename:32:-3}
    	prism $file $PROPS_FILE -const N=$N_START:$N_STEP:$UPPER_N -exportresults $OUTPUT_PATH/${outFileName}_results.txt > $OUTPUT_PATH/${outFileName}_out.txt 
	fi
done