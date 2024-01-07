FROM nvidia/cuda:11.7.1-base-ubuntu22.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y libgl1 libglib2.0-0 wget git git-lfs python3-pip python-is-python3 && \
 rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' user
RUN mkdir /sd && chown -R user:user /sd
WORKDIR /sd
USER user

RUN pip3 install --upgrade pip && \
    pip config set global.index-url  https://mirrors.aliyun.com/pypi/simple && \
    pip install xformers

RUN git clone https://github.com/camenduru/stable-diffusion-webui
RUN cd stable-diffusion-webui && python launch.py --skip-torch-cuda-test