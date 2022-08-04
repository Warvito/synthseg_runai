runai submit \
  --name volume-gather \
  --image 10.202.67.207:5000/wds20:synthseg_runai \
  --backoff-limit 0 \
  --gpu 0 \
  --cpu 4 \
  --large-shm \
  --run-as-user \
  --host-ipc \
  --project wds20 \
  --volume /nfs/home/wds20/projects/synthseg_runai/:/project/ \
  --volume /nfs/home/wds20/datasets/journal_transformer_generative/synthseg_results/our_final_igpts/:/target/ \
  --command -- sleep infinity