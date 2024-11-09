#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init --depth=1 -u https://github.com/AfterlifeOS/android_manifest.git -b 14 --git-lfs
git clone https://github.com/itsprofessorX/local_manifest.git --depth 1 -b master .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
fi


#build
. build/envsetup.sh
goafterlife r5x
