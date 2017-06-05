#!/bin/bash

if [ -f ./install.iso ]; then
	echo "Install"
	[ ! -f ./hdd.img ] && qemu-img create -f qcow2 ./hdd.img 64G
	./boot-install.sh
else
	if [ ! -f ./hdd.img ]; then
		echo "hdd.img is not exist!"
	else
		echo "Run Mac"
		./boot-mac.sh
	fi
fi
