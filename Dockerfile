FROM nvcr.io/nvidia/tensorflow:20.02-tf2-py3

ARG USER_ID
ARG GROUP_ID
ARG USER
RUN addgroup --gid $GROUP_ID $USER
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER

RUN git clone https://github.com/BBillot/SynthSeg.git \
  && cd SynthSeg \
  && git reset --hard cd597b080eb11bdd54e4e75b28b79b41b322c0c8 \

RUN pip3 install --upgrade pip
RUN pip3 install -r /workspace/SynthSeg/requirements.txt

WORKDIR /workspace/SynthSeg
