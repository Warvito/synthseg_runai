from tqdm import tqdm
import pandas as pd

ids_df = pd.read_csv(
    "/project/outputs/ids/existing_samples_subset_preprocessed.tsv",
    sep="\t"
)
volumes_list = []
for index, row in tqdm(ids_df.iterrows(), total=ids_df.shape[0]):
    volume_df = pd.read_csv(
        f"/target/{row['participant_id']}_{row['session_id'] }_T1w_sample/{row['participant_id']}_{row['session_id'] }_T1w_sample_decoded_vol.csv",
        sep=","
    )

    volume_dict = {}
    for column_name in volume_df.columns[1:]:
        volume_dict[column_name] = volume_df[column_name][1]
    volume_dict["participant_id"] = row['participant_id']
    volume_dict["session_id"] = row['session_id']

    volumes_list.append(volume_dict)

volumes_df = pd.DataFrame(volumes_list)
volumes_df.to_csv(
    "/project/outputs/volumes_synthseg.tsv",
    sep="\t",
    index=False
)