FROM nvidia/cuda:8.0-devel-ubuntu16.04

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
	wget \
	cmake \
	build-essential \
	libboost-all-dev
RUN mkdir -p /nheqminer; cd nheqminer
RUN wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.44-1_amd64.deb
RUN dpkg -i cuda-repo-ubuntu1604_8.0.44-1_amd64.deb
RUN apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y -q \
	cuda \
	cuda-toolkit-8-0
RUN apt update; \
    apt install -y -q git; \
    git clone -b Linux https://github.com/nicehash/nheqminer.git; \
    cd nheqminer/Linux_cmake/nheqminer_cuda_tromp && cmake . && make -j $(nproc)
