for i in {0..60}; do
  start=$(((${i} * 25)))
  stop=$((((${i} + 1) * 25)))
  runai submit \
    --name volume-${start}-${stop} \
    --image 10.202.67.207:5000/wds20:synthseg_runai \
    --backoff-limit 10 \
    --gpu 1 \
    --cpu 4 \
    --large-shm \
    --host-ipc \
    --project wds20 \
    --volume /nfs/home/wds20/projects/synthseg_runai/:/project/ \
    --volume /nfs/project/danieltudosiu/results/journal_transformer_generative/ukb/uniform_sampling/:/source/ \
    --volume /nfs/home/wds20/datasets/journal_transformer_generative/synthseg_results/uniform_sampling/:/target/ \
    --command -- bash /project/src/run_synthseg.sh \
    ${start} \
    ${stop}
done

for i in {0..60}; do
  start=$(((${i} * 25)))
  stop=$((((${i} + 1) * 25)))
  runai delete job volume-${start}-${stop}
done
