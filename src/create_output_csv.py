from tqdm import tqdm
import pandas as pd
from pathlib import Path

ids_df = pd.read_csv(
    "/project/outputs/ids/existing_samples_subset_preprocessed_HAGAN.tsv",
    sep="\t"
)
volumes_list = []
for index, row in tqdm(ids_df.iterrows(), total=ids_df.shape[0]):
    vol_path = Path(f"/target/{row['participant_id']}_{row['session_id'] }_T1w_sample/{row['participant_id']}_{row['session_id'] }_T1w_sample_decoded_vol.csv")
    if not vol_path.is_file():
        print(f"{str(vol_path)} does not exists!")
        continue

    volume_df = pd.read_csv(str(vol_path), sep=",")

    if len(volume_df) == 0:
        print(f"{str(vol_path)} does not have measures!")
        continue

    volume_dict = {}
    volume_dict["participant_id"] = row['participant_id']
    volume_dict["session_id"] = row['session_id']
    for column_name in volume_df.columns[1:]:
        volume_dict[column_name] = volume_df[column_name][0]

    volumes_list.append(volume_dict)

volumes_df = pd.DataFrame(volumes_list)
volumes_df.to_csv(
    "/project/outputs/volumes_synthseg_ukb_real.tsv",
    sep="\t",
    index=False
)