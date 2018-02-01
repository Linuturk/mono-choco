# Example Usage

This directory contains an example package and Dockerfile.

The **mypackage** directory was generated using the following command. Note you will need to fix the ownership of these files as they are generated as the root user inside the container.

```bash
docker run -ti --rm -v $PWD:/root -w /root linuturk/mono-choco new mypackage --version 1.0.0 --maintainer "Justin Phelps"
```

There are some modifications necessary to the generated nuspec file before it will generate a package. Check the file's git history to see those changes.