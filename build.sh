#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/PixelOS-AOSP/manifest.git -b fifteen --git-lfs --depth=1
git clone https://github.com/itsprofessorX/local_manifest.git -b Pos .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync
fi


#build
. build/envsetup.sh
lunch aosp_r5x-ap4a-userdebug
mka installclean
mka bacon
