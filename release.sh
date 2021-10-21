#!/usr/bin/env bash
#
# Release a version of the docker container.
# Triggers docker build of latest and tag version number.
# Assumes last commit is release version.
# Uses the commit message and release message.
# Uses version from VERSION file
#

set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


hub release create -m "$(git --no-pager log -n 1 --pretty=%B)" "$(cat "${__dir}/VERSION")"
