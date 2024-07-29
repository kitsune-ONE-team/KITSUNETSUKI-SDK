FROM docker.io/library/ubuntu:24.04

# skips timezone settings
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y \
    bison cmake ffmpeg git git-lfs imagemagick kmod openjdk-21-jre openssh-server \
    p7zip-full patchelf sudo wget unzip
RUN apt install -y \
    build-essential cxxtest gettext mesa-common-dev mesa-utils \
    python3-pip python3-venv uuid-dev
RUN apt install -y \
    libgl1-mesa-dev libglu1-mesa-dev libxxf86dga-dev libxxf86vm-dev libxrender-dev \
    libxext-dev libgtk2.0-dev libxkbcommon-x11-dev libdecor-0-dev libgbm-dev libwayland-dev \
    linux-libc-dev libusb-1.0-0-dev libopenal-dev libjpeg-dev libpng-dev \
    libfreetype-dev libcap2-bin libffi-dev libssl-dev libxi6 libreadline-dev
RUN apt install -y \
    mingw-w64 mingw-w64-tools mingw-w64-x86-64-dev \
    g++-mingw-w64 libz-mingw-w64-dev
RUN apt clean && \
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime && \
    echo UTC > /etc/timezone
RUN python3 -m venv /app/.venv
COPY requirements.txt /app/requirements.txt
RUN /app/.venv/bin/pip install -r /app/requirements.txt
RUN useradd jenkins -m -d /home/jenkins -s /bin/bash && \
    mkdir -p /app/build && \
    mkdir -p /app/opt && \
    chown jenkins:jenkins /app -R && \
    echo jenkins:jenkins | chpasswd
WORKDIR /root
