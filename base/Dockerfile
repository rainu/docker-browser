FROM ubuntu:16.04
MAINTAINER rainu <rainu@raysha.de>
ENV DEBIAN_FRONTEND noninteractive

#install dbus and audio support
RUN apt-get update &&\
	apt-get -y install software-properties-common &&\
	apt-add-repository multiverse &&\
	apt-get update &&\ 
	apt-get -y install dbus-x11 pulseaudio &&\
	apt-add-repository --remove multiverse &&\
	apt-get -y remove software-properties-common &&\
	apt-get -y autoremove &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/browser && \
    echo "browser:x:${uid}:${gid}:Browser User,,,:/home/browser:/bin/bash" >> /etc/passwd && \
    echo "browser:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/browser
