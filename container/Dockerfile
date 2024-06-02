FROM docker.io/library/ubuntu:22.04

# skips timezone settings
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y \
    git git-lfs subversion kmod sudo wget imagemagick ffmpeg p7zip-full openjdk-21-jre
RUN apt install -y \
    build-essential bison cmake python3-pip patchelf cxxtest gettext \
    linux-libc-dev libusb-1.0-0-dev \
    libcap2-bin libffi-dev libssl-dev libxi6 uuid-dev libreadline-dev
RUN apt install -y \
    mingw-w64 mingw-w64-tools mingw-w64-x86-64-dev \
    g++-mingw-w64 libz-mingw-w64-dev
RUN apt install -y \
    mesa-common-dev mesa-utils libgl1-mesa-dev libglu1-mesa-dev \
    libxxf86dga-dev libxxf86vm-dev libxrender-dev libxext-dev libgtk2.0-dev
RUN apt clean && \
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime && \
    echo UTC > /etc/timezone && \
    ln -sf /home /var/home
RUN pip3 install jenkins_job_builder==5.0.4
RUN wget -q -O /opt/jenkins.war https://updates.jenkins.io/download/war/2.459/jenkins.war
WORKDIR /root
