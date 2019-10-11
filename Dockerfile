FROM mono:3.12.1 as builder
ARG CHOCOVERSION=stable

RUN echo "deb http://archive.debian.org/debian/ wheezy main contrib non-free" >/etc/apt/sources.list
RUN apt-get update && apt-get install -y wget tar gzip

WORKDIR /usr/local/src
RUN wget "https://github.com/chocolatey/choco/archive/${CHOCOVERSION}.tar.gz"
RUN tar -xzf "${CHOCOVERSION}.tar.gz"
RUN mv "choco-${CHOCOVERSION}" choco

WORKDIR /usr/local/src/choco
RUN chmod +x build.sh zip.sh
RUN ./build.sh -v


FROM debian:stretch
RUN apt-get update && apt-get install -y mono-devel curl && apt-get clean all
RUN curl https://gist.githubusercontent.com/TheCakeIsNaOH/57254dc7f99b528d495e4f4e52de7f03/raw/ee936d6efddac485091ca6de833863f04ea77e39/Go%2520Daddy%2520Secure%2520Certificate%2520Authority%2520-%2520G2.crt >> /etc/ssl/certs/ca-certificates.crt
RUN cert-sync /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /usr/local/src/choco/build_output/chocolatey /opt/chocolatey
COPY bin/choco /usr/bin/choco

ENTRYPOINT ["/usr/bin/choco"]
CMD ["-h"]
