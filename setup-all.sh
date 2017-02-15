#!/bin/sh

set -e
set -x

# Path of device containing Distribution (CentOS 7) install disk
ISO_PATH=

function usage() {
    echo "Usage: $0 [-i <Path to device containing ISO file>]"
}

# Get command-line options
while getopts ":i:" opt; do
    case "${opt}" in
        i)
            ISO_PATH=${OPTARG}
            ;;
        \?)
            echo "Invalid option: $OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

# Check if argument was set
if [ -z "${ISO_PATH}" ]; then
    usage
    exit 1;
fi

### Install packages, scripts and setup ISO tree

# Install packages
./install-packages.sh

# Install kernel
./install-kernel.sh

# Install missing packages from tarballs or from source
./install-re2c.sh

# Install missing xorriso package and dependencies from tarballs or from source
./install-xorriso.sh

# Install missing szip from PUIAS repository
./install-szip.sh

# Setup initscripts
./setup-initscripts.sh

# Setup ISO tree
./setup-iso-tree.sh -i ${ISO_PATH}

# Setup BPM app packages
./setup-bpm-app.sh

# Fix generated ISO for USB bootable support
./fix-usb-boot-iso.sh

# Setup Repo for building ISO image of distribution
./setup-repo.sh
