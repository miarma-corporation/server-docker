FROM ubuntu:16.04
MAINTAINER Niclas Lindtedt <nicl@slindstedt.se>
ENV REFRESHED_AT 2017-08-12
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
  && apt-get install -y \
  curl \
  gcc \
  git \
  libc6-dev \
  make \
  pkg-config \
  unzip \
  wget \
  && rm -rf /var/lib/apt/lists/* \
&& git clone https://github.com/deurk/mvdsv.git \
  && cd mvdsv/build/make \
  && ./configure \
  && make \
  && mv mvdsv /root/mvdsv \
  && cd .. \
  && rm -rf mvdsv \
&& git clone https://github.com/deurk/ktx.git \
  && cd ktx \
  && ./configure \
  && make dl \
  && mv qwprogs.so /root/qwprogs.so \
  && cd .. \
  && rm -rf ktx \
&& git clone https://github.com/deurk/qtv.git \
  && cd qtv \
  && make \
  && mv qtv.bin /root/qtv.bin \
  && cd .. \
  && rm -rf qtv \
&& git clone https://github.com/deurk/qwfwd.git \
  && cd qwfwd \
  && ./configure \
  && make \
  && mv qwfwd.bin /root/qwfwd.bin \
  && cd .. \
  && rm -rf qwfwd

RUN curl -O -s https://raw.githubusercontent.com/nQuake/server-linux/master/src/install_nquakesv.sh \
&& chmod +x install_nquakesv.sh \
  && sleep 1 \
  && ./install_nquakesv.sh -n -q -d /nquakesv \
  && ln -s /root/.nquakesv /etc/nquakesv \
  && mv /root/mvdsv /nquakesv/mvdsv \
  && mv /root/qwprogs.so /nquakesv/ktx/qwprogs.so \
  && mv /root/qtv.bin /nquakesv/qtv/qtv.bin \
  && mv /root/qwfwd.bin /nquakesv/qwfwd/qwfwd.bin \
&& apt-get purge --auto-remove -y \
  curl \
  gcc \
  git \
  libc6-dev \
  make \
  pkg-config \
  unzip \
  wget

WORKDIR ["/nquakesv"]
ENTRYPOINT ["/nquakesv/start_servers.sh"]
CMD ["mvdsv", "27500"]
