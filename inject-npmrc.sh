#!/usr/bin/env bash
curDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[[ $1 ]] || { echo "missing an argument. first argument must be jfrog email" >&2; exit 1; }
[[ $2 ]] || { echo "missing an argument. first argument must be jfrog token for user with email: ${1}" >&2; exit 1; }
jfrog_email="${1}"
jfrog_password="${2}"

mkdir ${curDir}/tmp
cat > ${curDir}/tmp/.npmrc << EOF
_auth = ${jfrog_password}
email = ${jfrog_email}
always-auth = true
EOF