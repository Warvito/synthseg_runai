ids_file="/project/outputs/ids/existing_samples_preprocessed.tsv"
for i in 0; do
  start=$((${i} * 10))
  stop=$(((${i} + 1) * 10))

  runai submit \
    --name testing \
    --image 10.202.67.207:5000/wds20:synthseg_runai \
    --backoff-limit 0 \
    --gpu 1 \
    --cpu 4 \
    --large-shm \
    --node-type "dgx2-a" \
    --run-as-user \
    --host-ipc \
    --project wds20 \
    --volume /nfs/home/wds20/projects/synthseg_runai/:/project/ \
    --volume /nfs/project/danieltudosiu/results/journal_transformer_generative/ukb/ours/:/source/ \
    --volume /nfs/project/danieltudosiu/results/journal_transformer_generative/synthseg_results/ukb/ours/:/target/ \
    --command -- bash /project/src/run_synthseg.sh \
    ${start} \
    ${stop} \
    ${ids_file}
done