# OpenWRT Builder

Setup an [OpenWRT Buildroot](http://wiki.openwrt.org/doc/howto/buildroot.exigence) enviornment in a VM.

## Install

* Install [VirtualBox](https://www.virtualbox.org)
* Install [Vagrant](http://vagrantup.com/)
* (Optionally) install [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)
* Check out the repository; do something with `git submodule` to pull the OpenWRT repository.
* Run `vagrant up`
* You may need to run `vagrant reload` to ensure VirtualBox guest additions are setup.
* `vagrant ssh` to login
* Code is in `/mnt/openwrt` on the guest and `build/` on the host.
* Follow (buildroot compilation directions)[http://wiki.openwrt.org/doc/howto/buildroot.exigence]
