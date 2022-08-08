for i in {0..10}; do
  start=$(((${i} * 10)))
  stop=$((((${i} + 1) * 10)))

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
    --volume /nfs/project/danieltudosiu/results/journal_transformer_generative/adni/hagan/:/source/ \
    --volume /nfs/home/wds20/datasets/journal_transformer_generative/synthseg_results/adni_hagan/:/target/ \
    --command -- bash /project/src/run_synthseg.sh \
    ${start} \
    ${stop}
done

for i in {0..10}; do
  start=$(((${i} * 10)))
  stop=$((((${i} + 1) * 10)))
  runai delete job volume-${start}-${stop}
done