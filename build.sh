#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/ProjectPixelage/android_manifest.git -b 15 --git-lfs --depth=1
git clone https://github.com/itsprofessorX/local_manifest.git -b master .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune
fi

#build
. build/envsetup.sh
lunch pixelage_r5x-ap4a-userdebug
mka installclean
mka bacon
