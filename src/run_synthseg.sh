#!/bin/bash
printf '%s\n' --------------------
echo ARGS
printf '%s\n' --------------------

minimum=${1}
maximum=${2}

echo "Reading between ${minimum} and ${maximum}"

COUNTER=0
while IFS=$'\t' read -r -a myArray; do
  if (($COUNTER >= ${minimum} && $COUNTER < ${maximum})); then
    INPUT_IMG="/source/${myArray[0]}_T1w.nii.gz"
    OUTPUT_IMG="/target/${myArray[0]}_T1w/"
    OUTPUT_VOL="/target/${myArray[0]}/${myArray[0]}_T1w_vol.csv"

    echo ${COUNTER}
    echo ${INPUT_IMG}
    echo ${OUTPUT_IMG}
    echo ${OUTPUT_VOL}

    python ./scripts/commands/SynthSeg_predict.py --i ${INPUT_IMG} --o ${OUTPUT_IMG} --vol ${OUTPUT_VOL}

    COUNTER=$[$COUNTER +1]
  else
    COUNTER=$[$COUNTER +1]
  fi
done < "/project/outputs/ids/existing_samples_subset_preprocessed_lsgan.tsv"