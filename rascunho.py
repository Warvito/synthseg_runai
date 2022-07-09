import pandas as pd

ids_df = pd.read_csv(
    "/home/walter/Desktop/synthseg_runai/outputs/ids/existing_samples.tsv",
    sep="\t"
)

ids_df["participant_id"] = ids_df["path"].str[75:86]
ids_df["session_id"] = ids_df["path"].str[87:92]

ids_df.to_csv(
    "/home/walter/Desktop/synthseg_runai/outputs/ids/existing_samples_preprocessed.tsv",
    sep="\t",
    index=False
)