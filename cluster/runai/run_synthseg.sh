
for i in {0..1}; do
  start=$((1+(${i} * 100)))
  stop=$((1+((${i} + 1) * 100)))

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
    --volume /nfs/project/danieltudosiu/results/journal_transformer_generative/ukb/our_final_igptm/:/source/ \
    --volume /nfs/project/danieltudosiu/results/journal_transformer_generative/synthseg_results/ukb/our_final_igptm/:/target/ \
    --command -- bash /project/src/run_synthseg.sh \
    ${start} \
    ${stop}
done


for i in {0..30}; do
  start=$((1+(${i} * 100)))
  stop=$((1+((${i} + 1) * 100)))
  runai delete job volume-${start}-${stop}
done


