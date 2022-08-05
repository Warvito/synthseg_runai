
for i in 0; do
  start=$((1+(${i} * 50)))
  stop=$((1+((${i} + 1) * 50)))

  runai submit \
    --name volume-${start}-${stop} \
    --image 10.202.67.207:5000/wds20:synthseg_runai \
    --backoff-limit 0 \
    --gpu 0.5 \
    --cpu 4 \
    --large-shm \
    --run-as-user \
    --host-ipc \
    --node-type "dgx2-a" \
    --project wds20 \
    --volume /nfs/home/wds20/projects/synthseg_runai/:/project/ \
    --volume /nfs/project/danieltudosiu/results/journal_transformer_generative/ukb/uniform_sampling/:/source/ \
    --volume /nfs/home/wds20/datasets/journal_transformer_generative/synthseg_results/uniform_sampling/:/target/ \
    --command -- bash /project/src/run_synthseg.sh \
    ${start} \
    ${stop}
done



for i in {0..40}; do
  start=$((1+(${i} * 100)))
  stop=$((1+((${i} + 1) * 100)))
  runai delete job volume-${start}-${stop}
done


