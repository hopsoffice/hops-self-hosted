#!/usr/bin/env bash
set -e
tmp=$(mktemp -d)
version="0.1"
curl -L "https://github.com/hopsoffice/hops-self-hosted/releases/download/$version/releases$version.tar.gz" > "$tmp/releases$version.tar.gz"
tar xvfz "$tmp/releases$version.tar.gz"
rm -rf $tmp

install_dir="hops_self_hosted_$version"
if [ -d "$install_dir" ]; then
  echo -e "\n\n[Alert]\n$install_dir already exists, move to $install_dir.old\n\n"
  mv "$install_dir" "$install_dir.old"
fi
mv "releases$version" "$install_dir"

echo -e "\n\n[Info]\ninstalled on $install_dir"
echo -e "You need to run install.sh & login registry before running docker compose up\n"
echo -e "\t$ cd $install_dir"
echo -e "\t$ ./install.sh"
echo -e "\t$ docker login registry.hopsoffice.com"
echo -e "\t$ docker compose up"
