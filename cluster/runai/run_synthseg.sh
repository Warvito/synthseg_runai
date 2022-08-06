
for i in {0..53}; do
  start=$(((${i} * 20)))
  stop=$((((${i} + 1) * 20)))

  runai submit \
    --name volume-${start}-${stop} \
    --image 10.202.67.207:5000/wds20:synthseg_runai \
    --backoff-limit 0 \
    --gpu 0.5 \
    --cpu 4 \
    --large-shm \
    --host-ipc \
    --node-type "dgx2-a" \
    --project wds20 \
    --volume /nfs/home/wds20/projects/synthseg_runai/:/project/ \
    --volume /nfs/project/danieltudosiu/results/journal_transformer_generative/ukb/lsgan/:/source/ \
    --volume /nfs/home/wds20/datasets/journal_transformer_generative/synthseg_results/lsgan/:/target/ \
    --command -- bash /project/src/run_synthseg.sh \
    ${start} \
    ${stop}
done



for i in {0..53}; do
  start=$(((${i} * 20)))
  stop=$((((${i} + 1) * 20)))
  runai delete job volume-${start}-${stop}
done


