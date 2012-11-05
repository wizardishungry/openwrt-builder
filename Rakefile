# -*- mode: ruby -*-
# vi: set ft=ruby :

input_path = "./bin/x86"
input_image = "#{input_path}/openwrt-x86-generic-combined-ext4.img"
disk_image = "./disks/openwrt.vdi"
file input_image_compressed = "#{input_image}.gz"
guest_ts = File.stat(input_image_compressed).ctime.to_i
vm_name = "OpenWrt #{guest_ts}"
lan_name = "vboxnet0"
#bridge_name = "en1" # my WiFi card on OSX
bridge_name = `VBoxManage list bridgedifs | awk -F: '/^Name/ { print $2 }'|head -n 1` # Let's try magic!

file input_image => input_image_compressed do
  sh "gunzip -c \"#{input_image_compressed}\" > \"#{input_image}\""
end

file disk_image => input_image do
  sh "VBoxManage convertfromraw --format VDI \"#{input_image}\" \"#{disk_image}\""
end

task :vbox_build => :build_image do
  sh "VBoxManage hostonlyif remove '#{lan_name}' ; echo -n"
  sh "VBoxManage dhcpserver remove --ifname '#{lan_name}' ; echo -n"
  sh "VBoxManage hostonlyif create"
  sh "VBoxManage hostonlyif ipconfig '#{lan_name}' --ip 192.168.1.30 --netmask 255.255.255.0"
  sh "VBoxManage dhcpserver add --ifname '#{lan_name}' --ip 192.168.56.1 --netmask 255.255.255.0 --lowerip 192.168.56.100 --upperip 192.168.56.200; echo -n"
  sh "VBoxManage dhcpserver modify --ifname '#{lan_name}' --enable"
  sh "VBoxManage createvm --name \"#{vm_name}\" --register"
  sh "VBoxManage storagectl \"#{vm_name}\" --name \"SATA Controller\" --add sata --controller IntelAhci"
  sh "VBoxManage storageattach \"#{vm_name}\" --storagectl \"SATA Controller\" --port 0 --device 0 --type hdd --medium \"#{disk_image}\""
  sh "VBoxManage modifyvm \"#{vm_name}\" --nictype1 Am79C970A --nic1 intnet --intnet1 '#{lan_name}'"

  # use bridging
  #sh "VBoxManage modifyvm \"#{vm_name}\" --nictype2 Am79C970A --nic2 bridged --bridgeadapter2 #{bridge_name}"

  # use nat for WAN
  sh "VBoxManage modifyvm \"#{vm_name}\" --nictype2 Am79C970A --nic2 nat --natdnsproxy1 on"
  sh "VBoxManage modifyvm \"#{vm_name}\" --natpf1 \"guestssh,tcp,,2222,,22\""

end

task :vbox_launch => :vbox_build do
  sh "VBoxManage startvm \"#{vm_name}\""
end

task :build_image => disk_image
task :default => :vbox_build
