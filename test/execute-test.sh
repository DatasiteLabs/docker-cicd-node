#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

ls -la
Xvfb :99 & export DISPLAY=:99
npm run test
pkill Xvfb
