# mono-choco

Docker image for creating a container with Chocolatey running on Mono

## Usage

Test the image using `docker run --rm -v $PWD:$PWD -w $PWD linuturk/mono-choco`

See [the example directory](./example/README.md) for a basic package example.

## FAQ

1. "Cannot create a package that has no dependencies nor content."

Check your nuspec file for the line that reads:

```xml
<!--Building from Linux? You may need this instead: <file src="tools/**" target="tools" />-->
```