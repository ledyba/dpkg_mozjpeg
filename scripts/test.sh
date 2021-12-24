#! /bin/bash -eux

set -eux

## git リポジトリ上の root のパスを取得
ROOT_DIR="$(readlink -f "$(cd "$(dirname "$(readlink -f "$0")")" && cd .. && pwd)")"
cd "${ROOT_DIR}"

apt-get update

apt install -y ./artifact/*.deb
apt show mozjpeg
which cjpeg
which djpeg

cjpeg -version
djpeg -version

cjpeg -version 2>&1 | grep -io mozjpeg
djpeg -version 2>&1 | grep -io mozjpeg

set +e
ldd $(which cjpeg)
ldd $(which djpeg)
