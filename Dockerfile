FROM ubuntu:16.04
MAINTAINER Niclas Lindtedt <nicl@slindstedt.se>
ENV REFRESHED_AT 2017-08-12
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y apt-utils \
  && apt-get install -y \
  unzip \
  wget \
  curl \
  git \
  gcc \
  libc6-dev \
  make \
  pkg-config \
  && rm -rf /var/lib/apt/lists/*

# Build and install mvdsv
RUN git clone https://github.com/deurk/mvdsv.git \
  && cd mvdsv/build/make \
  && ./configure \
  && make \
  && mv mvdsv /root/mvdsv \
  && cd .. \
  && rm -rf mvdsv

# Build and install ktx
RUN git clone https://github.com/deurk/ktx.git \
  && cd ktx \
  && ./configure \
  && make dl \
  && mv qwprogs.so /root/qwprogs.so \
  && cd .. \
  && rm -rf ktx

# Build and install qtv
RUN git clone https://github.com/deurk/qtv.git \
  && cd qtv \
  && make \
  && mv qtv.bin /root/qtv.bin \
  && cd .. \
  && rm -rf qtv

# Build and install qwfwd
RUN git clone https://github.com/deurk/qwfwd.git \
  && cd qwfwd \
  && ./configure \
  && make \
  && mv qwfwd.bin /root/qwfwd.bin \
  && cd .. \
  && rm -rf qwfwd

# Install nQuakesv
RUN curl -O -s https://raw.githubusercontent.com/nQuake/server-linux/master/src/install_nquakesv.sh
RUN chmod +x install_nquakesv.sh \
  && sleep 1 \
  && ./install_nquakesv.sh -n -q -d /nquakesv
RUN ln -s /root/.nquakesv /etc/nquakesv
RUN mv /root/mvdsv /nquakesv/mvdsv \
  && mv /root/qwprogs.so /nquakesv/ktx/qwprogs.so \
  && mv /root/qtv.bin /nquakesv/qtv/qtv.bin \
  && mv /root/qwfwd.bin /nquakesv/ktx/qwfwd.bin

WORKDIR ["/nquakesv"]
ENTRYPOINT ["/nquakesv/start_servers.sh"]
CMD ["mvdsv", "27500"]
