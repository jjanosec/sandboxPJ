#!/bin/bash
#
# prerequisities - Debian packages:
# git
# gcc-arm-linux-gnueabihf
# devscripts
# kernel-package
#

KERNELREPO="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git"
KERNELBRANCH="linux-4.20.y"


export ARCH=arm64
export CROSS_COMPILE=/usr/bin/aarch64-linux-gnu-

if [ -d linux ]; then
  cd linux
  git checkout $KERNELBRANCH
  git pull origin $KERNELBRANCH
  make distclean
else
  git clone --single-branch --branch $KERNELBRANCH $KERNELREPO linux
fi

cd linux
#make mox_defconfig

export DEB_HOST_ARCH=arm64
export CONCURRENCY_LEVEL=`grep -m1 cpu\ cores /proc/cpuinfo | cut -d : -f 2`

#make-kpkg --rootcmd fakeroot --arch arm64 --cross-compile aarch64-linux-gnu- --revision=1.0 kernel_image kernel_headers

#make-kpkg --rootcmd fakeroot --arch arm64 --cross-compile aarch64-linux-gnu- --revision=1.0 configure debian kernel_image kernel_headers kernel_source

make-kpkg --rootcmd fakeroot --arch arm64 --cross-compile aarch64-linux-gnu- --config oldconfig --revision=1.0 configure buildpackage

make-kpkg --rootcmd fakeroot --arch arm64 --cross-compile aarch64-linux-gnu- --config oldconfig --revision=1.0 configure debian kernel_image kernel_headers kernel_source

make-kpkg --rootcmd fakeroot --arch arm64 --cross-compile aarch64-linux-gnu- --config oldconfig --revision=1.0 configure debian binary
