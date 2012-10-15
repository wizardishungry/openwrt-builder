# OpenWRT Builder

Setup an [OpenWRT Buildroot](http://wiki.openwrt.org/doc/howto/buildroot.exigence) enviornment in a VM.

## Install

* Install [VirtualBox](https://www.virtualbox.org)
* Install [Vagrant](http://vagrantup.com/)
* (Optionally) install [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)
* Install [Veewee](https://github.com/jedi4ever/veewee)
* Check out the repository.
* Run `vagrant up`
* You may need to run `vagrant reload` to ensure VirtualBox guest additions are setup.
* `vagrant ssh` to login
* Code is in `/mnt/openwrt` on the guest. We're not mounting from host to guest because hard links on virtualbox filesystems don't work on all platforms.
* Follow [buildroot compilation directions](http://wiki.openwrt.org/doc/howto/buildroot.exigence) from step 3
