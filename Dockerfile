# FROM ubuntu:rolling
FROM ubuntu:16.04
MAINTAINER Mirek

ENV DEBIAN_FRONTEND=noninteractive
# EXPOSE 22 4000
EXPOSE 23 4001



RUN apt-get update -y && apt-get install -y aptitude && aptitude dist-upgrade --purge-unused -y && aptitude clean
RUN apt-get install -y software-properties-common python-software-properties python3-software-properties sudo

# install useful apps
RUN apt-get install -y nano htop vim xterm ssh openssh-server curl wget git mc
# install Open JDK 8 and 9
RUN apt-get install -y openjdk-8-jdk # openjdk-9-jdk 

RUN add-apt-repository universe
#RUN add-apt-repository ppa:ubuntubudgie/backports
# RUN add-apt-repository ppa:webupd8team/tor-browser
RUN apt-get update -y

RUN apt-get install -y locales
RUN localedef -i en_IE -c -f UTF-8 -A /usr/share/locale/locale.alias en_IE.UTF-8
ENV LANG en_IE.utf8
#ENV LANG="en_IE.UTF-8"
ENV LANGUAGE=en_IE


#RUN apt-get install -y ubuntu-gnome-desktop
#RUN apt-get install -y kubuntu-full kubuntu-restricted-addons kubuntu-restricted-extras
RUN apt-get install -y lubuntu-desktop lubuntu-restricted-addons lubuntu-restricted-extras
#RUN apt-get install -y ubuntu-budgie-desktop budgie-indicator-applet

#RUN apt-get install -y pulseaudio cups libgconf2-4 iputils-ping libnss3 libxss1 xdg-utils libpango1.0-0 fonts-liberation
# RUN apt-get install -y firefox libreoffice chromium-browser

#Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
RUN sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get update -y && apt-get install -y google-chrome-stable

#http://docs.aws.amazon.com/directoryservice/latest/admin-guide/join_linux_instance.html
#RUN apt-get -y install sssd realmd krb5-user samba-common

# Goto https://www.nomachine.com/download/download&id=10 and change for the latest NOMACHINE_PACKAGE_NAME and MD5 shown in that link to get the latest version.
# ENV NOMACHINE_PACKAGE_NAME nomachine_5.3.12_10_amd64.deb
# ENV NOMACHINE_MD5 78f25ceb145b1e6972bb6ad2c69bf689
ENV NOMACHINE_PACKAGE_NAME nomachine_6.0.78_1_amd64.deb
ENV NOMACHINE_BUILD 6.0
ENV NOMACHINE_MD5 3645673090788ea0b2a3f664bb71a7dd

# Install nomachine, change password and username to whatever you want here
RUN curl -fSL "http://download.nomachine.com/download/${NOMACHINE_BUILD}/Linux/${NOMACHINE_PACKAGE_NAME}" -o nomachine.deb \
&& echo "${NOMACHINE_MD5} *nomachine.deb" | md5sum -c - && dpkg -i nomachine.deb


# Cleanup 
#RUN apt-get autoclean \
#    && apt-get autoremove \
#    && rm -rf /var/lib/apt/lists/*

RUN sed -i '/DefaultDesktopCommand/c\DefaultDesktopCommand "/usr/bin/startlxde"' /usr/NX/etc/node.cfg


ADD nxserver.sh /

ENTRYPOINT ["/nxserver.sh"]
