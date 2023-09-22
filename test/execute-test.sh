#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

ls -la
Xvfb :99 & export DISPLAY=:99

npm run installed-browsers
npm run ci:e2e -- -p e2e:electron $(npm run installed-browsers | grep "cypress run --browser" | sed -e 's/- cypress run --browser \(.*\)/e2e:\1/' | tr '\n' ' ')
npm run ci:test
pkill Xvfb
