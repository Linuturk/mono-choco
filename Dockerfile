FROM mono:6.12.0
ARG CHOCOVERSION=stable

# Make sure we have these tools
RUN apt-get update && apt-get install -y wget tar gzip

# Download, extract, and move chocolatey installer
WORKDIR /usr/local/src
RUN wget "https://github.com/chocolatey/choco/archive/${CHOCOVERSION}.tar.gz" && \
    tar -xzf "${CHOCOVERSION}.tar.gz" && \
    rm "${CHOCOVERSION}.tar.gz" && \
    mv "choco-${CHOCOVERSION}" choco

# Build chocolatey
WORKDIR /usr/local/src/choco
RUN chmod +x build.sh zip.sh
RUN ./build.sh -v

# Symlink the build output to our install directory
RUN ln -s /usr/local/src/choco/code_drop/chocolatey /opt/chocolatey

# Copy in the choco helper script
COPY bin/choco /usr/bin/choco

ENV ChocolateyInstall /opt/chocolatey

ENTRYPOINT ["/usr/bin/choco"]
CMD ["-h"]
