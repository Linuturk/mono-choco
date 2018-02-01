FROM mono:3.12.1 as builder
ARG chocoVersion=stable

RUN apt-get update && apt-get install -y wget tar gzip

WORKDIR /usr/local/src/choco
RUN wget "https://github.com/chocolatey/choco/archive/$chocoVersion.tar.gz"
RUN tar -xzf "$chocoVersion.tar.gz"

WORKDIR /usr/local/src/choco/choco-$chocoVersion
RUN chmod +x build.sh zip.sh
RUN ./build.sh -v


FROM alpine
ARG chocoVersion=stable

RUN apk add --no-cache mono --repository http://nl.alpinelinux.org/alpine/edge/testing
COPY --from=builder "/usr/local/src/choco/choco-$chocoVersion/build_output/chocolatey" /opt/chocolatey
COPY bin/choco /usr/bin/choco

ENTRYPOINT ["/usr/bin/choco"]
