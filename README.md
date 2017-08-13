# mono-choco

Docker image for creating a container with Chocolatey running on Mono

## Usage

1. Start the container in interactive mode: `docker run -ti --rm linuturk/mono-choco /bin/bash`
2. Test Chocolatey with: `choco -h`
    - You should see the help message from choco.exe

To build a Chocolatey package, you can mount a local directory as volume with the `-v` option and then `choco pack` the `*.nuspec` file.
