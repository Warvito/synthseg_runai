
for i in {0..100}; do
  start=$((1+(${i} * 25)))
  stop=$((1+((${i} + 1) * 25)))

  runai submit \
    --name volume2-${start}-${stop} \
    --image 10.202.67.207:5000/wds20:synthseg_runai \
    --backoff-limit 0 \
    --gpu 1 \
    --cpu 4 \
    --large-shm \
    --host-ipc \
    --project wds20 \
    --volume /nfs/home/wds20/projects/synthseg_runai/:/project/ \
    --volume /nfs/project/danieltudosiu/results/journal_transformer_generative/ukb/ccegan/:/source/ \
    --volume /nfs/home/wds20/datasets/journal_transformer_generative/synthseg_results/ccegan/:/target/ \
    --command -- bash /project/src/run_synthseg.sh \
    ${start} \
    ${stop}
done



for i in {0..100}; do
  start=$((1+(${i} * 25)))
  stop=$((1+((${i} + 1) * 25)))
  runai delete job volume2-${start}-${stop}
done


