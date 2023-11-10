#!/usr/bin/env bash
dir="releases$@"
rm -rf build && mkdir -p "$dir"
cp configure.sh "$dir"
cp docker-compose.yaml "$dir"
cp envoy.yaml "$dir"
cp README.md "$dir"

tar cvfz "$dir".tar.gz "$dir"
rm -rf "$dir"
