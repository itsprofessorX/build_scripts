#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/Evolution-X/manifest -b udc --git-lfs
git clone https://github.com/itsprofessorX/local_manifest.git --depth 1 -b master .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
fi


#build
. build/envsetup.sh
lunch lineage_r5x-ap2a-userdebug
mka installclean
m evolution
