#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/PixelOS-Fifteen/manifest.git -b fifteen --git-lfs --depth=1
git clone https://github.com/itsprofessorX/local_manifest.git --depth 1 -b master .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
fi


#build
. build/envsetup.sh
lunch aosp_r5x-ap3a-user
mka installclean
mka bacon
  
