This directory contains json files for building custom
AMIs using [packer](https://www.packer.io/intro/getting-started/build-image.html).

# Available configurations

| Name | Base Image | Json |
|------+------------+------|
| "bioc_2018-{{timestamp}}" | "name": "Bioc 3.8 R 3.5.1" | bioc_2018.json |


# Getting started

To install packer:

```sh
brew install packer
```

AWS credentials can be specified multiple different ways, 
but the standard credentials file (`~/.aws/credentials`)
works well to keep secrets out of the code.

To build a machine:

```sh
packer build JSON_FILE
```

The machine will start and the build will begin. Packer
streams the output to the local screen, so it is easy to track
progress. When complete, the image will be available with the
given name. 


# Configuration

## AMI permissions

The AMI can be built as a "public" image by using:

```
"ami_groups": ["all"]
```

