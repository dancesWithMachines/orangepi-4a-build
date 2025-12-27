# orangepi-4a-build

OS-buildsystem for [Orange Pi 4a](http://www.orangepi.org/orangepiwiki/index.php/Orange_Pi_4A).

This repository is a downstream of OrangePis'
[orangepi-build](https://github.com/orangepi-xunlong/orangepi-build) repository, focused on
Orange Pi 4a.

## What was changed

The major change compared to the upstream build system is addicion of `docker`, so the build
environment is reproducible and so it can run on any host. The `/docker` directory consists of two
major parts:

* `dockerfile` - the dockerfile itself, based on Ubuntu 22.04 as per Orange Pi recommendation.
* `run.sh` - handles building the image and starting the container with all required settings for
  the OS build to succeeds. Additionaly rebuilds the image if any change in dockerfile is detected.

As of now there are no changes to build system (scripts) itself. The `prepare.sh` script applies
necessary changes to the build evironment (eg. creating symlinks due to path changes) for the
build to suceed without altering builsystem logic. The reason for this approach is easier
maitenance.

All changes (docker setup + `prepare.sh` script) are contained within as a single, non-invasive
commit, which means, the base can be synced with upstream anytime and the commit should be
easy "rebaseable".

## Docker: How to

**Before attempting any of the following, make sure you have `docker` installed!**

_Note: Tested on Debian Trixie 13.2_

List of steps:

1. Clone and enter this repository locally.

    ```bash
    gic clone https://github.com/dancesWithMachines/orangepi-4a-build.git && cd orangepi-4a-build
    ```

1. Run `docker/run.sh` script to build and start the container.

    ```bash
    docker/run.sh
    ```

    _Note: On first start, the script will build the docker image automatically. The image is
    set to rebuild everytime the checksum of `docker/dockerfile` changes._

1. Inside the container, run `prepare.sh` script.

    ```bash
    ./prepare.sh
    ```
    
    The script applies some minor fixes to the build environment so the OS build succeeds. You can
    learn the details by studying the script itself.

1. Now one can follow
   [the official guide](http://www.orangepi.org/orangepiwiki/index.php/Orange_Pi_4A#Linux_SDK.E2.80.94.E2.80.94orangepi-build_usage_instructions)
   for building the OS image. A brief instruction can be found in the "[OS Build](#os-build-how-to)"
   of this readme.

## OS Build: How to

List of steps:

1. Start `build.sh` script

    ```bash
    sudo ./build.sh # runs as root anyway
    ```
1. Select `orangepi4a` board.
1. Select `Full OS image for flashing`. This option will additionally build all dependencies
   (`u-boot`, `kernel`, `rootfs`).
1. Proceed with default options until the build starts. The resulting image will be Debian Bookworm
   based CLI (server, no GUI) image.

## Clear the environment

The following command will clean all build files.

```bash
# Make sure you run this inside the repository!
# sudo rm -rf .tmp kernel output toolchains u-boot userpatches
```