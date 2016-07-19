FROM ubuntu:16.04
MAINTAINER rainu <rainu@raysha.de>
ENV DEBIAN_FRONTEND noninteractive

#install dbus and audio support
RUN apt-get update &&\
	apt-get -y install software-properties-common &&\
	apt-add-repository multiverse &&\
	apt-get update &&\ 
	apt-get -y install dbus-x11 pulseaudio gstreamer1.0-pulseaudio gstreamer1.0-plugins-good ubuntu-restricted-extras libgl1-mesa-glx-lts-vivid libgl1-mesa-dri-lts-vivid libtxc-dxtn-s2tc0 mesa-vdpau-drivers-lts-vivid libvdpau-va-gl1 i965-va-driver vdpau-va-driver &&\
	apt-add-repository --remove multiverse &&\
	apt-get -y remove software-properties-common &&\
	apt-get -y autoremove &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Workaround: pulseaudio client library likes to remove /dev/shm/pulse-shm-* 
#             files created by the host, causing sound to stop working. 
#             To fix this, we either want to disable the shm or mount /dev/shm 
#             in read-only mode when starting the container. 
RUN echo "enable-shm = no" >> /etc/pulse/client.conf

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/browser && \
    echo "browser:x:${uid}:${gid}:Browser User,,,:/home/browser:/bin/bash" >> /etc/passwd && \
    echo "browser:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/browser
