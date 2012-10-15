# OpenWrt Builder

Setup an [OpenWrt Buildroot](http://wiki.openwrt.org/doc/howto/buildroot.exigence) enviornment in a VirtualBox environment, build OpenWrt, boot to OpenWrt in VirtualBox.
<img src="http://i.imgur.com/HL4qt.png">

## Install

* Install [VirtualBox](https://www.virtualbox.org)
* Install [Vagrant](http://vagrantup.com/)
* (Optionally) install [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)
* ~~Install [Veewee](https://github.com/jedi4ever/veewee)~~
* Check out the repository.
* Run `vagrant up`
* You may need to run `vagrant reload` to ensure VirtualBox guest additions are setup.
* `vagrant ssh` to login
* Code is in `/mnt/openwrt` on the guest. We're not mounting from host to guest because hard links on virtualbox filesystems don't work on all platforms.
* Once the Chef provisioner completes, you'll have an x86 VirtualBox image in `bin/x86`
* Run `rake` to setup a VirtualBox image for the OpenWrt build.
* Launch the VM from VirtualBox manager or run `rake vbox_launch`.

## Todo

* Combine Vagrantfile into Rakefile
* Use Veewee
* Provisioning for OpenWrt packages
* and for My Secret Project<sup>Â®</sup>
