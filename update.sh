#!/usr/bin/env bash

cd ./repos/"${1}"/ || exit 1
rm -v Packages* InRelease

apt-ftparchive packages ./debs > Packages
bzip2 -c9 Packages > Packages.bz2
xz -c9 Packages > Packages.xz
xz -5fkev --format=lzma Packages > Packages.lzma
lz4 -c9 Packages > Packages.lz4
gzip -c9 Packages > Packages.gz
zstd -c19 Packages > Packages.zst

apt-ftparchive contents ./debs > Contents-iphoneos-arm
apt-ftparchive contents ./debs > Contents-iphoneos-arm64e

bzip2 -c9 Contents-iphoneos-arm > Contents-iphoneos-arm.bz2
bzip2 -c9 Contents-iphoneos-arm64e > Contents-iphoneos-arm64e.bz2

xz -c9 Contents-iphoneos-arm > Contents-iphoneos-arm.xz
xz -c9 Contents-iphoneos-arm64e > Contents-iphoneos-arm64e.xz

xz -5fkev --format=lzma Contents-iphoneos-arm > Contents-iphoneos-arm.lzma
xz -5fkev --format=lzma Contents-iphoneos-arm64e > Contents-iphoneos-arm64e.lzma

lz4 -c9 Contents-iphoneos-arm > Contents-iphoneos-arm.lz4
lz4 -c9 Contents-iphoneos-arm64e > Contents-iphoneos-arm64e.lz4

gzip -c9 Contents-iphoneos-arm > Contents-iphoneos-arm.gz
gzip -c9 Contents-iphoneos-arm64e > Contents-iphoneos-arm64e.gz

zstd -c19 Contents-iphoneos-arm > Contents-iphoneos-arm.zst
zstd -c19 Contents-iphoneos-arm64e > Contents-iphoneos-arm64e.zst

if [ "${1}" = "my" ]; then
  apt-ftparchive release -c ../config/my.conf . > Release
else
  apt-ftparchive release -c ../config/iphoneos-arm64.conf . > Release
fi

echo "${2}" | gpg --batch --yes --pinentry-mode=loopback --passphrase-fd 0 -abs -u 896CC9E708C847210A2293F2997233590E26A3A2 -o Release.gpg Release
echo "${2}" | gpg --batch --yes --pinentry-mode=loopback --passphrase-fd 0 --clearsign -u 896CC9E708C847210A2293F2997233590E26A3A2 -o InRelease Release

cd -
