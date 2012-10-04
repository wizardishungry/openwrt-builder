# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "openwrt-builder"
  config.vm.host_name = "openwrt-builder"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://puppetlabs.s3.amazonaws.com/pub/squeeze64.box"

  config.vm.customize ["modifyvm", :id, "--memory", "2048"]
  if not (RUBY_PLATFORM.downcase.include?("mswin") or RUBY_PLATFORM.downcase.include?("mingw") )
    config.vm.customize ["modifyvm", :id, "--cpus",
      `awk "/^processor/ {++n} END {print n}" /proc/cpuinfo 2> /dev/null || sh -c 'sysctl hw.logicalcpu 2> /dev/null || echo ": 2"' | awk \'{print \$2}\' `.chomp ]
  end

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
   config.vm.share_folder "openwrt", "/mnt/openwrt", "./build"

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding 
  # some recipes and/or roles.
  #
  config.vm.provision :shell, :inline => "chef-solo --help 2>/dev/null 1>/dev/null || (apt-get -y install rubygems && gem install chef)"
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "./chef/cookbooks"
    chef.roles_path = "./chef/roles"
    chef.data_bags_path = "./chef/data_bags"
    #chef.add_recipe "mysql"
    chef.add_role "builder"
  
    # You may also specify custom JSON attributes:
    chef.json = { :mysql_password => "foo" }
  end
  
  # Install VBGuest plugin
  # vagrant gem install vagrant-vbguest
  # do NOT download the iso file from a webserver
  config.vbguest.no_remote = true

end
