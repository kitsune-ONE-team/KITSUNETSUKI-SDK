# ubuntu 20.04 LTS (focal)
FROM docker.io/library/ubuntu:20.04

# skips timezone settings
ENV DEBIAN_FRONTEND=noninteractive

RUN \
    apt update -y && \
    apt install -y \
        sudo kmod git subversion wget p7zip-full && \
    apt install -y \
        build-essential gettext linux-libc-dev libcap2-bin libxi6 uuid-dev && \
    apt install -y \
        mingw-w64 mingw-w64-tools mingw-w64-x86-64-dev \
        g++-mingw-w64 libz-mingw-w64-dev && \
    apt install -y \
        mesa-common-dev mesa-utils libgl1-mesa-dev libglu1-mesa-dev \
        libglew-dev libxxf86vm-dev cxxtest \
        libopenal-dev && \
    apt clean && \
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime && \
    echo UTC > /etc/timezone

RUN \
    wget -q -O /opt/miniconda3.sh \
        https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.3-Linux-x86_64.sh && \
    chmod +x /opt/miniconda3.sh && \
    /opt/miniconda3.sh -b -p /opt/miniconda3 && \
    /opt/miniconda3/bin/conda install -y conda==4.8.3 anaconda-client && \
    /opt/miniconda3/bin/conda clean -a -y && \
    ln -sf /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    rm -f /opt/miniconda3.sh
