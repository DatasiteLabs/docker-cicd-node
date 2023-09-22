#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cert_dir="${__dir}/certs"

mkdir -p "${cert_dir}"

if ! command -v mkcert > /dev/null; then
  echo "This repo requires mkcert to genearte a local trusted cert. Install with 'brew install mkcert' or follow os instructions."
fi

mkcert -install
mkcert host.docker.internal
mv *.pem "${cert_dir}"

if [[ ! -d "${HOME}/.docker/certs.d/" ]]; then
  mkdir -p "${HOME}/.docker/certs.d/"
fi

cp "${cert_dir}"/*.pem "${HOME}/.docker/certs.d/"
cp "$(mkcert -CAROOT)"/rootCA.pem "${HOME}/.docker/certs.d/"

existing_container_id=$(docker ps | grep registry | awk '{print $1}' || true)
if [[ ! -z "${existing_container_id}" ]]; then
  echo "Stopping and removing existing registry container ${existing_container_id}"
  docker stop "${existing_container_id}" && docker rm "${existing_container_id}"
fi

docker run -d \
  --restart=always \
  --name registry \
  -p 5001:5000 \
  -v "${cert_dir}":/certs \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/host.docker.internal.pem \
  -e REGISTRY_HTTP_TLS_KEY=/certs/host.docker.internal-key.pem \
  -p 443:443 \
  registry:2
