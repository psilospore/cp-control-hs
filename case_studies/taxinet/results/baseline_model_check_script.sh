MODEL_PATH=baseline_models
PROPS_FILE=properties/baseline_props.pctl
N_START=0
N_STEP=1
UPPER_N=30
OUTPUT_PATH=prism_output

for file in $MODEL_PATH/*; do
	filename=$(basename $file)
    echo 'Processing file:  '$filename
	if [[ $filename == *shielding* ]]; then
    	outFileName=baseline_with_shielding
    	prism $file $PROPS_FILE -const N=$N_START:$N_STEP:$UPPER_N -exportresults $OUTPUT_PATH/${outFileName}_results.txt > $OUTPUT_PATH/${outFileName}_out.txt 
	else
		outFileName=baseline
    	prism $file $PROPS_FILE -const N=$N_START:$N_STEP:$UPPER_N -exportresults $OUTPUT_PATH/${outFileName}_results.txt > $OUTPUT_PATH/${outFileName}_out.txt 
	fi
done