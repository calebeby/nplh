#!/usr/bin/env sh

rm -rf build
mkdir build

jq --version || apt-get install jq

redirects=""

redirect() {
  redirects=$redirects$1"   "$2$'\n'
}

latest=$(git describe --abbrev=0)
latest_url="$(curl \
  https://gitlab.com/api/v3/projects/nplh%2Fnplh/repository/tags/$latest | \
  jq -r ".release.description")"

redirect /dl $latest_url

echo "$redirects"
echo "$redirects" > build/_redirects
