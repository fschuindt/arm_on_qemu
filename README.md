# ARM on QEMU
A set of files to help running [Raspbian](https://www.raspbian.org/) images on x86_64 Linux machines. It uses [QEMU](https://www.qemu.org/) in order to emulate a ARM processor.

Thanks to [wimvanderbauwhede](https://github.com/wimvanderbauwhede) and his wiki [page](https://github.com/wimvanderbauwhede/limited-systems/wiki/Raspbian-%22stretch%22-for-Raspberry-Pi-3-on-QEMU).

## Features
- SSH connection.
- Read/Write bidirectional path mounting.

## Requirements
- Download the [Raspbian Stretch Lite](https://downloads.raspberrypi.org/raspbian_lite_latest) image and extract it to this repository root path.
- The `qemu-system-arm` package must be installed at the host.

*I'm using the `2018-11-13` release, if you're using a different one you will need to edit the `boot.sh` file.*

## Usage
Edit the `config.env` file to point to a existing path on your host machine. I use this path to edit ARM Assembly code from my x86_64 host and execute it via SSH into Raspbian.

After configured, run:
```bash
$ ./boot.sh
```

This will boot Raspbian on QEMU.

![raspbian](https://i.postimg.cc/y6cr0bgv/image.png)

### Mounting a host path
Once you're inside Raspbian, choose a destination path at the guest to mount it.  
Eg.: `/home/pi/host`

Create it:
```bash
~$ mkdir host
```

And add the following entry to the `/etc/fstab` file:
```
host0   /home/pi/host    9p      trans=virtio,version=9p2000.L   0 0
```

Then reload the fstab:
```
$ sudo mount -a
```

The path will be mounted.

### Connecting via SSH
At the guest:
```bash
$ sudo systemctl ssh start
```

At the host:
```bash
$ ssh -p 5555 pi@localhost
```
