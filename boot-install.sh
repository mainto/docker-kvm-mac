#!/bin/bash

# qemu-img create -f qcow2 mac_hdd.img 64G
# echo 1 > /sys/module/kvm/parameters/ignore_msrs
#
# Type the following after boot,
# -v "KernelBooter_kexts"="Yes" "CsrActiveConfig"="103"
#
# printf 'DE:AD:BE:EF:%02X:%02X\n' $((RANDOM%256)) $((RANDOM%256))
#
# no_floppy = 1 is required for OS X guests!
#
# Commit 473a49460db0a90bfda046b8f3662b49f94098eb (qemu) makes "no_floppy = 0"
# for pc-q35-2.3 hardware, and OS X doesn't like this (it hangs at "Waiting for
# DSMOS" message). Hence, we switch to pc-q35-2.4 hardware.
#
# Network device "-device e1000-82545em" can be replaced with "-device vmxnet3"
# for possibly better performance.

qemu-system-x86_64 -enable-kvm -m 4096 -cpu Penryn,kvm=off,vendor=GenuineIntel \
	  -machine pc-q35-2.4 \
	  -smp 4,cores=2 \
	  -usb -device usb-kbd -device usb-mouse \
	  -kernel ./enoch_rev2883_boot \
	  -smbios type=2 \
	  -device ide-drive,bus=ide.2,drive=MacHDD \
	  -drive id=MacHDD,if=none,file=./hdd.img \
	  -netdev user,id=usr0 -device e1000-82545em,netdev=usr0,id=vnet0 \
	  -device ide-drive,bus=ide.0,drive=MacDVD \
	  -drive id=MacDVD,if=none,snapshot=on,file=./install.iso \
	  -vnc 0.0.0.0:1 -k en-us
