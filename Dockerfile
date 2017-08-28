FROM mono:3.12.1

LABEL maintainer="Justin Phelps <linuturk@onitato.com>"

RUN apt-get update && apt-get install -y wget unzip

WORKDIR /usr/local/src/choco
RUN wget https://github.com/chocolatey/choco/archive/stable.zip
RUN unzip stable.zip
RUN rm stable.zip

WORKDIR /usr/local/src/choco/choco-stable
RUN chmod +x build.sh
RUN chmod +x zip.sh
RUN ./build.sh

WORKDIR /usr/local/bin
RUN ln -s /usr/local/src/choco/choco-stable/build_output/chocolatey

COPY choco /usr/local/bin/choco

WORKDIR /root
