FROM debian:jessie-backports
RUN apt-get update && apt-get -yq dist-upgrade
RUN apt-get install -yq apt-transport-https apt-utils iproute bash git-core wget auto-apt-proxy unzip
RUN echo "Acquire::http::Proxy \"http://172.17.0.2:3142\";" | tee -a /etc/apt/apt.conf.d/00proxy
RUN echo "Acquire::https::Proxy-Auto-Detect \"/usr/bin/auto-apt-proxy\";" | tee -a /etc/apt/apt.conf.d/00proxy
RUN echo "Acquire::http::Proxy-Auto-Detect \"/usr/bin/auto-apt-proxy\";" | tee /etc/apt/apt.conf.d/auto-apt-proxy.conf
RUN groupadd -r -g 64040 grsec-tpe;
RUN adduser --home /home/lede-build/ --shell /bin/bash --disabled-password lede-build
RUN usermod -aG grsec-tpe lede-build; true
#RUN wget -O /home/lede-build/v17.01.2.tar.gz https://github.com/lede-project/source/archive/v17.01.2.tar.gz
RUN wget -O /home/lede-build/v17.01.2.zip https://github.com/lede-project/source/archive/master.zip
#RUN cd /home/lede-build && tar -xvzf v17.01.2.tar.gz
RUN cd /home/lede-build && unzip v17.01.2.zip -d /home/lede-build/source-17.01.2
RUN mv /home/lede-build/source-17.01.2 /home/lede-build/source
RUN apt-get install -yq build-essential perl-base devscripts wget libssl-dev \
        libncurses5-dev unzip gawk zlib1g-dev subversion mercurial bc binutils \
        bzip2 fastjar flex g++ gcc util-linux libgtk2.0-dev gettext unzip \
        zlib1g-dev file python libncurses5-dev intltool jikespg genisoimage \
        patch perl-modules rsync ruby sdcc unzip wget gettext xsltproc \
        libboost1.55-dev libxml-parser-perl libusb-dev bin86 bcc sharutils \
        openjdk-7-jdk curl

WORKDIR /home/lede-build/source


RUN ./scripts/feeds update -a
RUN ./scripts/feeds install -a

COPY files/ /home/lede-build/source/files
COPY kadnode/ /home/lede-build/source/package/kadnode

RUN chown --preserve-root -RL lede-build:lede-build /home/lede-build/source

USER lede-build
RUN make V=s defconfig
