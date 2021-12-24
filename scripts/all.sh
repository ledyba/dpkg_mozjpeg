#!/bin/bash

set -eux

## git リポジトリ上の scripts ディレクトリのパスを取得
ROOT_DIR="$(readlink -f "$(cd "$(dirname "$0")" && cd .. && pwd)")"

## パッケージのディレクトリ名
PKG_DIR="mozjpeg"

## ビルドに必要なパッケージのインストール
apt-get update
apt-get install -y --no-install-recommends build-essential debhelper devscripts debmake equivs
apt-get install -y --no-install-recommends lsb-release git bash

## ビルド時に必要なパッケージのインストール
env --chdir="${ROOT_DIR}/${PKG_DIR}" \
  mk-build-deps --install --remove \
  --tool='apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends --yes' \
  debian/control

## deb ファイルのビルド
bash "${ROOT_DIR}/scripts/create_changelog.sh"
bash "${ROOT_DIR}/scripts/build.sh"
