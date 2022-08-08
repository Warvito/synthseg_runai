
for i in {0..35}; do
  start=$((1+(${i} * 10)))
  stop=$((1+((${i} + 1) * 10)))

  runai submit \
    --name volume-${start}-${stop} \
    --image 10.202.67.207:5000/wds20:synthseg_runai \
    --backoff-limit 10 \
    --gpu 0.5 \
    --cpu 4 \
    --large-shm \
    --host-ipc \
    --project wds20 \
    --volume /nfs/home/wds20/projects/synthseg_runai/:/project/ \
    --volume /nfs/project/danieltudosiu/results/journal_transformer_generative/adni/ccegan/:/source/ \
    --volume /nfs/home/wds20/datasets/journal_transformer_generative/synthseg_results/adni_ccegan/:/target/ \
    --command -- bash /project/src/run_synthseg.sh \
    ${start} \
    ${stop}
done

for i in {0..40}; do
  start=$((1+(${i} * 100)))
  stop=$((1+((${i} + 1) * 100)))
  runai delete job volume-${start}-${stop}
done


