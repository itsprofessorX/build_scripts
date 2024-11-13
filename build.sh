#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/RisingTechOSS/android -b fifteen --git-lfs
git clone https://github.com/itsprofessorX/local_manifest.git --depth 1 -b master .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
fi


#build
. build/envsetup.sh
riseup r5x userdebug
rise b
  
