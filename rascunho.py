import pandas as pd

ids_df = pd.read_csv(
    "/media/walter/Storage/Projects/synthseg_runai/outputs/ids/adni/ls_gan_samples.csv",
    sep="\t"
)

ids_df["participant_id"] = ids_df["path"].str[6:14]
ids_df["filename"] = ids_df["path"].str[6:-7]
ids_df["session_id"] = ids_df["path"].str[15:27]


ids_df.to_csv(
    "/media/walter/Storage/Projects/synthseg_runai/outputs/ids/adni/adni_lsgan.tsv",
    sep="\t",
    index=False
)