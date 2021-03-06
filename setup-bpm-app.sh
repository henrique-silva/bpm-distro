#!/bin/sh

set -e
set -x

# Source environment variables
. ./repo-versions.sh

TOP_DIR=$(pwd)

# Setup dirs
mkdir -p kickstart_build/isolinux/postinstall/apps
cd kickstart_build/isolinux/postinstall/apps

# Remove a psosibly old bpm-app repo
rm -rf bpm-app

# Clone BPM App repo
git clone --recursive --branch=${BPM_APP_VERSION} https://github.com/lnls-dig/bpm-app

# Download the repos, but don't install them
cd bpm-app
./get-all.sh -r server -b afcv3_1 -a yes -f rpm -e yes -x yes -l yes -c yes -p yes -o

# Copy MANIFEST file to base directory
cp MANIFEST ${TOP_DIR}

cd ${TOP_DIR}
