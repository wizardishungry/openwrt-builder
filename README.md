# OpenWRT Builder

Setup an [OpenWRT Buildroot](http://wiki.openwrt.org/doc/howto/buildroot.exigence) enviornment in a VM.

## Install

* Install [VirtualBox](https://www.virtualbox.org)
* Install [Vagrant](http://vagrantup.com/)
* (Optionally) install [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)
* Check out the repository.
* Run `vagrant up`
* You may need to run `vagrant reload` to ensure VirtualBox guest additions are setup.
* `vagrant ssh` to login
* Right now we're building a VM but not doing anything with it. Building is slow; we should make this use rake, etc.
* Code is in `/mnt/openwrt` on the guest. We're not mounting from host to guest because hard links on virtualbox filesystems don't work on all platforms.