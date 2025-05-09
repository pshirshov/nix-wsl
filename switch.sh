#!/usr/bin/env bash

set -xe

pushd .

cd "$(dirname "$0")"

git add .
git commit -am "wip"

sudo nixos-rebuild switch --flake .

git push

popd
