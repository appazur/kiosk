echo WARNING: each version needs a new version number.
set -e
cp manifest.chrome.json src/manifest.json
pushd src
FNAME=appazur-kiosk.zip
zip -r ../$FNAME *
popd
