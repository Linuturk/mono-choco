# mono-choco

[Latest Build Status](https://hub.docker.com/r/linuturk/mono-choco/builds)

Docker image for creating a container with Chocolatey running on Mono

## Usage

Test the image using `docker run --rm -v $PWD:$PWD -w $PWD linuturk/mono-choco`

See [the example directory](./example/README.md) for a basic package example.

## FAQ

1. "Cannot create a package that has no dependencies nor content."

The nuspec file most likely requires this for the files section:
```xml
  <files>
    <file src="tools/**" target="tools" />
  </files>

```
Note the comment in the nuspec template that reads:

```xml
<!--Building from Linux? You may need this instead: <file src="tools/**" target="tools" />-->
```
