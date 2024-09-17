#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync

git clone https://github.com/itsprofessorX/local_manifest.git --depth 1 -b master .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
fi


#build
. build/envsetup.sh
lunch aosp_sweet-ap2a-user
mka installclean
mka bacon
