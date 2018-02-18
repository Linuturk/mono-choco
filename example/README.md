# Example Usage

This directory contains an example package and Dockerfile.

## Generating a new package

The **mypackage** directory was generated using the following command. Note you will need to fix the ownership of these files as they are generated as the root user inside the container.

```bash
docker run --rm -v $PWD:$PWD -w $PWD linuturk/mono-choco new mypackage --version 1.0.0 --maintainer "Justin Phelps"
```

There are some modifications necessary to the generated nuspec file before it will generate a package. Check the file's git history to see those changes.

## Recommended packing method

I recommend you use the Dockerfile example in this directory to pack your nuget packages. Doing everything from inside the Docker container is cleaner. If you would still like to run this with a volume mount, here is an example of that command:

```bash
cd /path/to/mypackage
docker run --rm -v $PWD:$PWD -w $PWD linuturk/mono-choco pack mypackage.nuspec
Chocolatey v0.10.9.0
Directory 'opt/chocolatey/lib' does not exist.

Chocolatey is not an official build (bypassed with --allow-unofficial).
 If you are seeing this message and it is not expected, your system may
 now be in a bad state. Only official builds are to be trusted.

Attempting to build package from 'mypackage.nuspec'.
Successfully created package 'mono-choco/example/mypackage/mypackage.1.0.0.nupkg'
```
