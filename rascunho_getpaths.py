from pathlib import Path
import pandas as pd

source_dir = Path("/source/")

data_list = []
for image_path in source_dir.glob("*.nii.gz"):
    print(image_path)
    data_list.append(
        {
            "path": str(image_path),
            "participant_id": str(image_path)[8:19],
            "session_id": str(image_path)[20:25],
        }
    )

data_df = pd.DataFrame(data_list)
data_df.to_csv(
    "/project/outputs/ids/existing_samples_subset_preprocessed_HAGAN.tsv",
    index=False,
    sep="\t"
)