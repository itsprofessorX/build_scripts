#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/ProjectMatrixx/android.git -b 14.0 --git-lfs
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
git clone https://github.com/itsprofessorX/local_manifest.git --depth 1 -b master .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
fi


#build
. build/envsetup.sh
lunch aosp_r5x-ap2a-userdebug
mka installclean
mka bacon
