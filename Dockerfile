FROM debian:sid
RUN apt-get update && apt-get -yq dist-upgrade
RUN apt-get install -yq auto-apt-proxy apt-transport-https apt-utils iproute
RUN echo "Acquire::http::Proxy \"http://172.17.0.2:3142\";" | tee -a /etc/apt/apt.conf.d/00proxy
RUN echo "Acquire::https::Proxy-Auto-Detect \"true\";" | tee -a /etc/apt/apt.conf.d/00proxy
RUN echo "Acquire::http::Proxy-Auto-Detect \"/usr/bin/auto-apt-proxy\";" | tee /etc/apt/apt.conf.d/auto-apt-proxy.conf
RUN apt-get install -yq build-essential perl-base devscripts bash git-core
RUN adduser --home /home/lede-build/ --shell /bin/bash --disabled-password lede-build
RUN chown -R lede-build:lede-build /home/lede-build/
RUN git clone https://github.com/eyedeekay/lede-source /home/lede-build/
WORKDIR /home/lede-build/
USER lede-build
RUN ./scripts/feeds update -a
