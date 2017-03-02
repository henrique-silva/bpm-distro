#!/bin/sh

set -e
set -x

# Specific packages versions
KERNEL_VERSION=$(repoquery --enablerepo=elrepo-kernel kernel-lt | sed -e "s/kernel-lt-0:\([0-9]*.[0-9]*.[0-9]*-[0-9]\).*/\1/g")
KERNEL_VERSION_SUFFIX="el7.elrepo.x86_64"
KERNEL_VERSION_FULL=${KERNEL_VERSION}.${KERNEL_VERSION_SUFFIX}

# We export these variables as other scripts will use it
export HALCS_KERNEL_DIR=/lib/modules/${KERNEL_VERSION_FULL}/build
export HALCS_DRIVER_INSTALL_DIR=/lib/modules/${KERNEL_VERSION_FULL}/extra
export HALCS_KERNEL_VERSION=${KERNEL_VERSION_FULL}

# Package versions
RE2C_VERSION=0.13.5-1
SZIP_VERSION=2.1-1
XORRISO_VERSION=1.4.6-1
LIBBURN_VERSION=1.4.6-1
LIBISOBURN_VERSION=1.4.6-1
LIBISOFS_VERSION=1.4.6-1

# BPM versions
BPM_DISTRO_VERSION=master
BPM_APP_VERSION=master
