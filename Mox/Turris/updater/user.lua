-- Luci
Install("luci", "luci-lighttpd", { priority = 40 })
Install("luci-base", "luci-proto-ipv6", "luci-proto-ppp", "luci-app-commands", { priority = 40 })
-- Luci Controls
Install("luci-app-ahcp", "luci-app-firewall", { priority = 40 })
Install("luci-proto-openconnect", "luci-proto-relay", "luci-proto-vpnc", { priority = 40 })
Install("luci-theme-bootstrap", { priority = 40 })
-- LXC
Install("kmod-veth", { priority = 40 })
Install("lxc", { priority = 40 })
Install("lxc-attach", "lxc-auto", "lxc-console", "lxc-create", "lxc-info", "lxc-ls", "lxc-monitor", "lxc-monitord", "lxc-snapshot", "lxc-start", "lxc-stop", { priority = 40 })
Install("luci-app-lxc", { priority = 40 })
Install("foris-storage-plugin", { priority = 40 })
Install("gnupg", "gnupg-utils", "tar", "wget", { priority = 40 })
-- NAS
Install("mount-utils", "losetup", "lsblk", "blkid", "file", { priority = 40 })
Install("fdisk", "cfdisk", "hdparm", "resize2fs", "partx-utils", { priority = 40 })
Install("acl", "attr", { priority = 40 })
Install("foris-storage-plugin", { priority = 40 })
Install("lvm2", "mdadm", "dosfstools", "mkhfs", "btrfs-progs", "davfs2", "e2fsprogs", "fuse-utils", "xfs-mkfs", { priority = 40 })
Install("block-mount", "badblocks", "cifsmount", "hfsfsck", "xfs-fsck", "xfs-growfs", { priority = 40 })
Install("sshfs", { priority = 40 })
Install("wget", "rsync", "rsyncd", "samba36-client", "samba36-server", { priority = 40 })
