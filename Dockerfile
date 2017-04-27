FROM ubuntu

RUN apt-get update && apt-get install curl wget unzip -y
RUN curl -O https://raw.githubusercontent.com/nQuake/server-linux/master/src/install_nquakesv.sh && \
	chmod +x install_nquakesv.sh && \
	./install_nquakesv.sh -n -q $NQHOSTNAME -p=1 -a=$NQADMIN -e=$NQADMINEMAIL -r=$NQRCON $NQINSTALLDIR && \
	cd $NQINSTALLDIR

CMD [ "./run/port1.sh" ]
