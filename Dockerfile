FROM alpine:latest
MAINTAINER Niclas Lindtedt <nicl@slindstedt.se>
ENV REFRESHED_AT 2017-08-17

RUN apk update
RUN apk upgrade

RUN apk add unzip curl screen ca-certificates openssl git alpine-sdk
RUN update-ca-certificates

# Install mvdsv
RUN git clone https://github.com/deurk/mvdsv.git && \
  cd mvdsv/build/make && \
  ./configure && \
  make && \
  mv mvdsv /root/mvdsv

# Install ktx
RUN git clone https://github.com/deurk/ktx.git && \
  cd ktx && \
  ./configure && \
  make dl && \
  mv qwprogs.so /root/qwprogs.so

# Install nQuakesv
RUN curl -O -s https://raw.githubusercontent.com/nQuake/server-linux/master/src/install_nquakesv.sh
RUN chmod +x install_nquakesv.sh && sleep 1 && ./install_nquakesv.sh -n /nquakesv
RUN ln -s /root/.nquakesv /etc/nquakesv
RUN echo "/nquakesv" > /etc/nquakesv/install_dir
RUN mv /root/mvdsv /nquakesv/mvdsv
RUN mv /root/qwprogs.so /nquakesv/ktx/qwprogs.so

EXPOSE 27500

WORKDIR ["/nquakesv"]
CMD ["/nquakesv/start_servers.sh"]
