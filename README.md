# MacOS on Docker KVM

### Host System Detail
* Ubuntu 16.04 running on i7-4790k

Intel VT-x / AMD SVM is required.



### Preparation
Follow **Installation Preparation** from [OSX-KVM](https://github.com/kholia/OSX-KVM)

You will get MacOS Install ISO and prepared QEMU system.

### Note
You need a VNC client to connect your virtual console.
- VNC console port is 5901.

After install, you can enable screen sharing and you can use VNC to control it.
- VNC screen sharing port is 5900.

### MacOS Install

##### When you install MacOS in container
HDD image will be created on docker container
```sh
sudo docker run --device /dev/kvm:/dev/kvm -p 5901:5901 \
    -v <MacOS Install ISO host path>:/macos/install.iso \
    mainto/macos:base-<VERSION>
```
###### example
```sh
sudo docker run --device /dev/kvm:/dev/kvm -p 5901:5901 \
    -v /home/user/Install_macOS_Sierra_(OS_X_10.12.5).iso:/macos/install.iso \
    mainto/macos:10.12.5
```

##### When you install MacOS on your own HDD image
```sh
sudo docker run --device /dev/kvm:/dev/kvm -p 5901:5901 \
    -v <Mac HDD IMG host path>:/macos/hdd.img \
    -v <MacOS Install ISO host path>:/macos/install.iso \
    mainto/macos:10.12.5
```
###### example
```sh
sudo docker run --device /dev/kvm:/dev/kvm -p 5901:5901 \
    -v /home/user/hdd.img:/macos/hdd.img \
    -v /home/user/Install_macOS_Sierra_(OS_X_10.12.5).iso:/macos/install.iso \
    mainto/macos:10.12.5
```
* VNC port 5901 for console

### MacOS Boot

##### When you created docker image after install
```sh
sudo docker run --device /dev/kvm:/dev/kvm \
    -p 5900:5900 -p 5901:5901 \ 
    <YOUR IMAGE>
```

##### When you have your own HDD image
```sh
sudo docker run --device /dev/kvm:/dev/kvm \
    -p 5900:5900 -p 5901:5901 \
    -v <Mac HDD IMG host path>:/macos/hdd.img \
    mainto/macos:10.12.5
```
* VNC port 5900 for screen sharing (You need to enable on MacOS system preferences)
* VNC port 5901 for console
