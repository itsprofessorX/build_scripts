#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/GenesisOS/manifest.git -b verve --git-lfs
git clone https://github.com/itsprofessorX/local_manifest.git --depth 1 -b master .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -j$(nproc --all) --force-sync --no-tags --no-clone-bundle --prune --optimized-fetch
fi


#build
source build/envsetup.sh
breakfast r5x
mka installclean
mka genesis
  
