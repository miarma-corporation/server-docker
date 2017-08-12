FROM ubuntu:latest
MAINTAINER Niclas Lindtedt <nicl@slindstedt.se>
ENV REFRESHED_AT 2017-08-13

RUN apt-get update && apt-get install -y \
  unzip \
  wget \
  curl \
  screen \
  git \
  gcc \
  libc6-dev \
  make \
  && rm -rf /var/lib/apt/lists/*

# Install mvdsv
RUN git clone https://github.com/deurk/mvdsv.git \
  && cd mvdsv/build/make \
  && ./configure \
  && make \
  && mv mvdsv /root/mvdsv

# Install ktx
RUN git clone https://github.com/deurk/ktx.git \
  && cd ktx \
  && ./configure \
  && make dl \
  && mv qwprogs.so /root/qwprogs.so

# Install nQuakesv
RUN curl -O -s https://raw.githubusercontent.com/nQuake/server-linux/master/src/install_nquakesv.sh
RUN chmod +x install_nquakesv.sh \
  && sleep 1 \
  && ./install_nquakesv.sh -n /nquakesv
RUN ln -s /root/.nquakesv /etc/nquakesv
RUN echo "/nquakesv" > /etc/nquakesv/install_dir
RUN mv /root/mvdsv /nquakesv/mvdsv
RUN mv /root/qwprogs.so /nquakesv/ktx/qwprogs.so

WORKDIR ["/nquakesv"]
CMD ["/nquakesv/start_servers.sh"]
