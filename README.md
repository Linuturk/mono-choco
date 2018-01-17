# mono-choco

Docker image for creating a container with Chocolatey running on Mono

## Usage

Test the image using `docker run --rm linuturk/mono-choco -h`

To build a Chocolatey package, you can mount a local directory as volume with the `-v` option and then `choco pack` the `*.nuspec` file.
