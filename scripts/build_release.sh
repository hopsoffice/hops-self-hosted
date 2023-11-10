#!/usr/bin/env bash
dir="releases$@"
rm -rf "$dir" && mkdir -p "$dir"
cp configure.sh "$dir"
cp docker-compose.yaml "$dir"
cp envoy.yaml "$dir"
cp README.md "$dir"
mkdir -p "$dir/scripts"
cp ./scripts/build_env.sh "$dir/scripts/"

tar cvfz "$dir".tar.gz "$dir"
rm -rf "$dir"
