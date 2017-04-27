FROM ubuntu

RUN apt-get update && apt-get install curl unzip -y
RUN curl -s https://raw.githubusercontent.com/nQuake/server-linux/master/src/install_nquakesv.sh && \
    chmod +x install_nquakesv.sh && \
    ./install_nquakesv.sh -n -q -h $NQHOSTNAME -p=$NQPORTS -a=$NQADMIN -e=$NQADMINEMAIL -r=$NQRCON -y=$NQQTVPASS && \
    	$([ "$NQQTV" = "true" ] && echo "-t") && \
    	$([ "$NQQWFWD" = "true" ] && echo "-f") $NQINSTALLDIR
CMD /usr/local/nquakesv/start_servers.sh