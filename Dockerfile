FROM mono:6.8
ARG CHOCOVERSION=stable

# Add contrib and non-free
#RUN echo "deb http://archive.debian.org/debian/ stretch main contrib non-free" >/etc/apt/sources.list
RUN apt-get update && apt-get install -y wget tar gzip

# Import some additional certs
WORKDIR /tmp
RUN wget https://ssl-ccp.godaddy.com/repository/gdig2.crt.pem
RUN cat gdig2.crt.pem >> /etc/ssl/certs/ca-certificates.crt
RUN cert-sync /etc/ssl/certs/ca-certificates.crt

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
RUN ln -s /usr/local/src/choco/build_output/chocolatey /opt/chocolatey

# Copy in the choco helper script
COPY bin/choco /usr/bin/choco

ENTRYPOINT ["/usr/bin/choco"]
CMD ["-h"]
