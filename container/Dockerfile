FROM docker.io/library/ubuntu:22.04

# skips timezone settings
ENV DEBIAN_FRONTEND=noninteractive

RUN \
    apt update -y && \
    apt install -y \
        sudo kmod git git-lfs subversion wget imagemagick openssh-server p7zip-full && \
    apt install -y \
        cxxtest gettext linux-libc-dev libusb-1.0-0-dev libcap2-bin \
        libxi6 uuid-dev && \
    apt install -y \
        mingw-w64 mingw-w64-tools mingw-w64-x86-64-dev \
        g++-mingw-w64 libz-mingw-w64-dev && \
    apt install -y \
        mesa-common-dev mesa-utils libgl1-mesa-dev libglu1-mesa-dev \
        libglew-dev libopenal-dev \
        libxxf86dga-dev libxxf86vm-dev libxrender-dev libxext-dev && \
    apt install -y libavcodec-dev libxvidcore-dev && \
    apt install -y openjdk-11-jre && \
    apt clean && \
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime && \
    echo UTC > /etc/timezone && \
    ln -sf /home /var/home

RUN wget -q -O /opt/jenkins.war https://get.jenkins.io/war/2.413/jenkins.war
COPY ./run-jenkins /usr/local/bin/run-jenkins
COPY ./builder.yml /opt/builder.yml

RUN \
    wget -q -O /opt/miniconda3.sh \
        https://repo.anaconda.com/miniconda/Miniconda3-py310_23.3.1-0-Linux-x86_64.sh && \
    chmod +x /opt/miniconda3.sh && \
    /opt/miniconda3.sh -b -p /opt/miniconda3 && \
    ln -sf /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    /opt/miniconda3/bin/conda env create -f=/opt/builder.yml -p /opt/builder && \
    /opt/miniconda3/bin/conda clean -a -y && \
    rm -f /opt/miniconda3.sh
