FROM mono:3.12.1 as builder
ARG CHOCOVERSION=stable

RUN apt-get update && apt-get install -y wget tar gzip

WORKDIR /usr/local/src
RUN wget "https://github.com/chocolatey/choco/archive/${CHOCOVERSION}.tar.gz"
RUN tar -xzf "${CHOCOVERSION}.tar.gz"
RUN mv "choco-${CHOCOVERSION}" choco

WORKDIR /usr/local/src/choco
RUN chmod +x build.sh zip.sh
RUN ./build.sh -v


FROM alpine:latest

RUN apk add --no-cache mono --repository http://nl.alpinelinux.org/alpine/edge/testing && \
    apk add --no-cache shadow ca-certificates && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    apk del ca-certificates

COPY --from=builder /usr/local/src/choco/build_output/chocolatey /opt/chocolatey
COPY bin/choco /usr/bin/choco
COPY bin/entrypoint.sh /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["-h"]
