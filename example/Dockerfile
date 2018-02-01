FROM linuturk/mono-choco

ENV PACKAGE=mypackage
ENV VERSION=1.0.0

WORKDIR /opt/choco

# Copy our package files into the container
COPY ${PACKAGE} /opt/choco

# Check the files that were copied
RUN ls -R /opt/choco

# Check our version
RUN choco --version

# Pack the nupkg
RUN choco pack -vd /opt/choco/${PACKAGE}.nuspec --outputdirectory /opt/choco

# Example push command
#RUN choco push -vd --timeout 30 /opt/choco/${PACKAGE}.${VERSION}.nupkg
