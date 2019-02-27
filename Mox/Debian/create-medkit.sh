#!/bin/bash
MIRROR="http://ftp.cz.debian.org/debian/"
HOSTNAME="mox"
PASSWORD="mox"

BUILDROOT=`pwd`
ROOTDIR="/data/debian/root"

mkdir $ROOTDIR

# debootstrap stage1
debootstrap --arch arm64 --foreign stretch $ROOTDIR $MIRROR

# prepare QEMU
cp /usr/bin/qemu-aarch64-static $ROOTDIR/usr/bin/

# deboostrap stage2
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
 LC_ALL=C LANGUAGE=C LANG=C chroot $ROOTDIR /debootstrap/debootstrap --second-stage
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
 LC_ALL=C LANGUAGE=C LANG=C chroot $ROOTDIR dpkg --configure -a

# configure the system
echo -e "${PASSWORD}\n${PASSWORD}" | chroot $ROOTDIR passwd root

echo "$HOSTNAME" >$ROOTDIR/etc/hostname

cat >$ROOTDIR/etc/apt/sources.list <<EOF
deb $MIRROR stretch main
deb http://security.debian.org/ stretch/updates main
EOF

cat >$ROOTDIR/etc/fstab <<EOF
/dev/mmcblk1p1 / btrfs rw,relatime,ssd,subvol=@                 0       0
EOF

cat >$ROOTDIR/etc/network/interfaces <<EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
iface eth0 inet dhcp
EOF

chroot $ROOTDIR <<ENDSCRIPT
apt-get -y update
apt-get -y install openssh-server
ENDSCRIPT

sed -ir 's/^PermitRootLogin prohibit-password$/PermitRootLogin yes/' $ROOTDIR/etc/ssh/sshd_config

# cleanup QEMU
rm $ROOTDIR/usr/bin/qemu-aarch64-static

# create package
cd $ROOTDIR
touch ../mox-medkit.tar.gz
sudo tar zcf ../mox-medkit.tar.gz *
cd $BUILDROOT
d=`date "+%Y%m%d"`
mv mox-medkit.tar.gz mox-medkit-${d}.tar.gz
md5sum mox-medkit-${d}.tar.gz >mox-medkit-${d}.tar.gz.md5
#sudo rm -rf $ROOTDIR

