import pandas as pd

ids_df = pd.read_csv(
    "/media/walter/Storage/Projects/synthseg_runai/outputs/ids/our_uniform_sampling.csv",
    sep="\t"
)

ids_df["participant_id"] = ids_df["path"].str[6:17]
ids_df["session_id"] = ids_df["path"].str[18:23]

ids_df.to_csv(
    "/media/walter/Storage/Projects/synthseg_runai/outputs/ids/existing_samples_subset_preprocessed_uniform_sampling.tsv",
    sep="\t",
    index=False
)