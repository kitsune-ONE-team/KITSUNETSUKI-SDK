FROM docker.io/library/ubuntu:24.04

# skips timezone settings
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && \
    apt install -y \
        sudo bison cargo cmake curl flex file git git-lfs kmod openssh-server p7zip-full patchelf \
        ffmpeg imagemagick \
        build-essential cxxtest gettext mesa-common-dev mesa-utils uuid-dev \
        libasound2-dev libpulse-dev libpipewire-0.3-dev \
        liblzma-dev libgl1-mesa-dev libglu1-mesa-dev libffi-dev libssl-dev linux-libc-dev \
        mingw-w64 mingw-w64-tools mingw-w64-x86-64-dev g++-mingw-w64 libz-mingw-w64-dev && \
    apt clean

RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime && \
    echo UTC > /etc/timezone && \
    echo PermitRootLogin yes >> /etc/ssh/sshd_config && \
    echo root:nyanpassu | chpasswd && \
    curl -L micro.mamba.pm | bash

RUN curl -o /var/opt/lzma.7z -L https://www.7-zip.org/a/lzma2602.7z && \
    7z x -o/var/opt/lzma /var/opt/lzma.7z && \
    rm -f /var/opt/lzma.7z

RUN cd /var/opt && curl -o appimagetool.AppImage -L \
    https://github.com/AppImage/appimagetool/releases/download/1.9.1/appimagetool-x86_64.AppImage && \
    chmod +x appimagetool.AppImage && \
    mkdir appimagetool && cd appimagetool && \
    ../appimagetool.AppImage --appimage-extract && cd .. && rm -f appimagetool.AppImage

WORKDIR /app
