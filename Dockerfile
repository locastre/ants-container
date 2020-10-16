FROM ubuntu:20.04

ENV TZ=US/New_York
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get install -y wget cmake cmake-curses-gui gcc g++ git zlib1g-dev

RUN wget https://github.com/ANTsX/ANTs/archive/v2.3.4.tar.gz && \
	tar xvf v2.3.4.tar.gz && \
	mkdir ANTs-2.3.4/build && \
	cd ANTs-2.3.4/build && \
	cmake ../ && \
	make -j4

RUN	cd ANTS-build/Examples && \
	mkdir -p /opt/ants/bin && \
	cp  `ls | awk '! /\.a|\.cxx|\.cmake|Makefile|CMakeFiles|TestSuite/'` /opt/ants/bin && \
	mv /ANTs-2.3.4/Scripts /opt/ants && \ 
	chmod -R 755 /opt/ants && \
	rm -rf /ANTs-2.3.4 && \
	rm /v2.3.4.tar.gz

ENV ANTSPATH=/opt/ants/bin
ENV PATH=${ANTSPATH}:/opt/ants/Scripts:${PATH}
