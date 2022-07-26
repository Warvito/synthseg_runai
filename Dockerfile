FROM nvcr.io/nvidia/tensorflow:20.02-tf2-py3

ARG USER_ID
ARG GROUP_ID
ARG USER
RUN addgroup --gid $GROUP_ID $USER
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER

COPY requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

RUN git clone https://github.com/BBillot/SynthSeg.git \
  && cd SynthSeg \
  && git reset --hard 99d2ff2f45e56361842f13d39aebe09bc6ec5c9b

COPY ./outputs/models/synthseg_2.0.h5 /workspace/SynthSeg/models/
COPY ./outputs/models/synthseg_parc_2.0.h5 /workspace/SynthSeg/models/
COPY ./outputs/models/synthseg_qc_2.0.h5 /workspace/SynthSeg/models/
COPY ./outputs/models/synthseg_robust_2.0.h5 /workspace/SynthSeg/models/

WORKDIR /workspace/SynthSeg
