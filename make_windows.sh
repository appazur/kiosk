#!/bin/bash

# Dependencies (macOS):
#  brew install nsis
#  brew install p7zip

set -e
if [ -e package.nw ]; then
  rm package.nw
fi

cp manifest.nwjs.json src/manifest.json

pushd src
7z a -tzip ../package.nw *
popd
makensis windows_installer.nsi

# For emailing, zip it.
7z a -tzip AppazurInstaller.zip AppazurInstaller.exe
