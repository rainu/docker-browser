FROM rainu/browser-base:16.04
MAINTAINER rainu <rainu@raysha.de>
ENV DEBIAN_FRONTEND noninteractive

ENV TOR_BROWSER_LINK https://www.torproject.org/dist/torbrowser/6.0.5/tor-browser-linux64-6.0.5_de.tar.xz

#if the tor-browser has something to complain, print it on stderr instead of making a notification
ENV show_output 1

#install Flash
RUN apt-get update &&\
        apt-get -y install software-properties-common &&\
        apt-add-repository multiverse &&\
        apt-get update &&\	
	apt-get -y install flashplugin-installer &&\
	apt-add-repository --remove multiverse &&\
        apt-get -y remove software-properties-common &&\
        apt-get -y autoremove &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#download and extract tor-browser
RUN apt-get update &&\
        apt-get install xz-utils &&\
	wget -nv $TOR_BROWSER_LINK -O /tmp/tor.tar.xz &&\
        tar -xf /tmp/tor.tar.xz -C /opt/ && mv /opt/$(ls /opt/) /opt/tor/ &&\
        apt-get -y remove xz-utils &&\
        apt-get -y autoremove &&\
	rm /tmp/tor.tar.xz  &&\
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER browser

ENTRYPOINT ["/bin/bash"]
CMD ["/opt/tor/Browser/start-tor-browser"]
