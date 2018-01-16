FROM mono:3.12.1 as builder
RUN apt-get update && apt-get install -y wget unzip

WORKDIR /usr/local/src/choco
RUN wget https://github.com/chocolatey/choco/archive/stable.zip
RUN unzip stable.zip

WORKDIR /usr/local/src/choco/choco-stable
RUN chmod +x build.sh zip.sh && ./build.sh -v


FROM frolvlad/alpine-mono:latest

COPY --from=builder /usr/local/src/choco/choco-stable/build_output/chocolatey /opt/chocolatey
COPY choco /usr/bin/choco

ENTRYPOINT ["/usr/bin/choco"]