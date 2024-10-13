#!/usr/bin/env bash

cd ./repos/"${1}"/ || exit 1

arch="arm"
if [ "${1}" = "roothide" ]; then
  arch="${arch}64e"
fi

rm -v Packages* InRelease

apt-ftparchive packages ./debs > Packages
bzip2 -c9 Packages > Packages.bz2
xz -c9 Packages > Packages.xz
xz -5fkev --format=lzma Packages > Packages.lzma
lz4 -c9 Packages > Packages.lz4
gzip -c9 Packages > Packages.gz
zstd -c19 Packages > Packages.zst

apt-ftparchive contents ./debs > Contents-iphoneos-"${arch}"
bzip2 -c9 Contents-iphoneos-"${arch}" > Contents-iphoneos-"${arch}".bz2
xz -c9 Contents-iphoneos-"${arch}" > Contents-iphoneos-"${arch}".xz
xz -5fkev --format=lzma Contents-iphoneos-"${arch}" > Contents-iphoneos-"${arch}".lzma
lz4 -c9 Contents-iphoneos-"${arch}" > Contents-iphoneos-"${arch}".lz4
gzip -c9 Contents-iphoneos-"${arch}" > Contents-iphoneos-"${arch}".gz
zstd -c19 Contents-iphoneos-"${arch}" > Contents-iphoneos-"${arch}".zst

if [ "${1}" = "my" ]; then
  apt-ftparchive release -c ../config/my.conf . > Release
elif [ "${1}" = "roothide" ]; then
  apt-ftparchive release -c ../config/roothide.conf . > Release
else
  apt-ftparchive release -c ../config/iphoneos-arm64.conf . > Release
fi

echo "${2}" | gpg --batch --yes --pinentry-mode=loopback --passphrase-fd 0 -abs -u 896CC9E708C847210A2293F2997233590E26A3A2 -o Release.gpg Release
echo "${2}" | gpg --batch --yes --pinentry-mode=loopback --passphrase-fd 0 --clearsign -u 896CC9E708C847210A2293F2997233590E26A3A2 -o InRelease Release

cd -
