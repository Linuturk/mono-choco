FROM mono:3.12.1 as builder
ARG chocoVersion=stable

RUN apt-get update && apt-get install -y wget tar gzip

WORKDIR /usr/local/src
RUN wget https://github.com/chocolatey/choco/archive/$chocoVersion.tar.gz
RUN tar -xzf $chocoVersion.tar.gz
RUN mv choco-$chocoVersion choco

WORKDIR /usr/local/src/choco
RUN chmod +x build.sh zip.sh
RUN ./build.sh -v


FROM frolvlad/alpine-mono

RUN apk add --no-cache shadow
COPY --from=builder /usr/local/src/choco/build_output/chocolatey /opt/chocolatey/
COPY bin/choco /usr/bin/choco

ENTRYPOINT ["/usr/bin/choco"]
CMD ["-h"]
