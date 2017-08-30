FROM debian:jessie
RUN apt-get update && apt-get -yq dist-upgrade
RUN apt-get install -yq apt-transport-https apt-utils iproute bash git-core wget
RUN echo "Acquire::http::Proxy \"http://172.17.0.2:3142\";" | tee -a /etc/apt/apt.conf.d/00proxy
RUN echo "Acquire::https::Proxy-Auto-Detect \"true\";" | tee -a /etc/apt/apt.conf.d/00proxy
RUN echo "Acquire::http::Proxy-Auto-Detect \"/usr/bin/auto-apt-proxy\";" | tee /etc/apt/apt.conf.d/auto-apt-proxy.conf
RUN adduser --home /home/lede-build/ --shell /bin/bash --disabled-password lede-build
#RUN git clone https://github.com/eyedeekay/lede-source /home/lede-build/source
RUN wget https://github.com/lede-project/source/archive/v17.01.2.tar.gz
RUN tar -xvzf v17.01.2.tar.gz && mv source-17.01.2 source
RUN apt-get install -yq build-essential perl-base devscripts wget libssl-dev \
        libncurses5-dev unzip gawk zlib1g-dev subversion mercurial bc binutils \
        bzip2 fastjar flex g++ gcc util-linux libgtk2.0-dev gettext unzip \
        zlib1g-dev file python libncurses5-dev intltool jikespg genisoimage \
        patch perl-modules rsync ruby sdcc unzip wget gettext xsltproc \
        libboost1.55-dev libxml-parser-perl libusb-dev bin86 bcc sharutils \
        openjdk-7-jdk
WORKDIR /home/lede-build/source
RUN ./scripts/feeds update -a
RUN ./scripts/feeds install -a

COPY files/ /home/lede-build/source/files
COPY kadnode/ /home/lede-build/source/packages/kadnode
RUN chown --preserve-root -RL lede-build:lede-build /home/lede-build/source/

USER lede-build
RUN make defconfig
