FROM rainu/browser-base:16.04
MAINTAINER rainu <rainu@raysha.de>
ENV DEBIAN_FRONTEND noninteractive

# Google Hangouts
ENV PLUGIN_LINK https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
RUN cd /tmp && \
    wget $PLUGIN_LINK -O /tmp/google-talkplugin.deb
    dpkg -i google-talkplugin.deb && \
    rm -f google-talkplugin.deb

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

#install Firefox
RUN apt-get update &&\
       apt-get -y install firefox &&\
       apt-get clean &&\
       rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER browser

ENTRYPOINT ["/usr/bin/firefox"]
CMD ["--new-instance"]
