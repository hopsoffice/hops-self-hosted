#!/usr/bin/env bash
set -e
tmp=$(mktemp -d)
version="0.4"
echo "[I] Downloading hops-self-hosted..."
curl -sL "https://github.com/hopsoffice/hops-self-hosted/releases/download/$version/releases$version.tar.gz" > "$tmp/releases$version.tar.gz"
tar xfz "$tmp/releases$version.tar.gz"
rm -rf $tmp
echo "[I] Download Done."

install_dir="hops_self_hosted_$version"
if [ -d "$install_dir" ]; then
  target="$install_dir.$(date +%Y%m%d%H%M%S).old"
  echo -e "[W] $install_dir already exists, moved to $target"
  mv "$install_dir" "$target"
fi
mv "releases$version" "$install_dir"

echo
echo ":: 라이센스와 Docker Registry 정보를 입력해주세요."
echo
while [[ "$licenseId" == '' ]]
do
    read -sp "- 라이센스 아이디: " licenseId
    echo
done

while [[ "$registryId" == '' ]]
do
    read -p "- Docker Registry 유저 이름: " registryId
done

while [[ "$registryPw" == '' ]]
do
    read -sp "- Docker Registry 패스워드: " registryPw
done

"./$install_dir/scripts/build_env.sh" "" "" "" "" "" "" "" "" "" "$licenseId" "" > "$install_dir/.env"

echo "$registryPw" | docker login registry.hopsoffice.com -u "$registryId" --password-stdin
echo
echo "다운로드 및 설정이 완료되었습니다."
echo "$install_dir 로 이동하셔서 Docker Compose로 홉스를 실행하실 수 있습니다."
echo
echo "$ cd $install_dir"
echo "$ docker compose up -d"
