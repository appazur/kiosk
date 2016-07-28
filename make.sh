echo WARNING: each version needs a new version number.
pushd src
FNAME=appazur-kiosk.zip
zip -r ../$FNAME *
popd
