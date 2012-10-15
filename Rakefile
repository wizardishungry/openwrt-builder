# -*- mode: ruby -*-
# vi: set ft=ruby :

input_path = "./bin/x86"
input_image = "#{input_path}/openwrt-x86-generic-combined-ext4.img"
disk_image = "./disks/openwrt.vdi"
file input_image_compressed = "#{input_image}.gz"
guest_ts = File.stat(input_image_compressed).ctime.to_i
vm_name = "OpenWrt #{guest_ts}"

file input_image => input_image_compressed do
  sh "gunzip -c \"#{input_image_compressed}\" > \"#{input_image}\""
end

file disk_image => input_image do
  sh "VBoxManage convertfromraw --format VDI \"#{input_image}\" \"#{disk_image}\""
end

task :vbox_build => :build_image do
  sh "VBoxManage createvm --name \"#{vm_name}\" --register"
  sh "VBoxManage storagectl \"#{vm_name}\" --name \"SATA Controller\" --add sata --controller IntelAhci"
  sh "VBoxManage storageattach \"#{vm_name}\" --storagectl \"SATA Controller\" --port 0 --device 0 --type hdd --medium \"#{disk_image}\""
  sh "VBoxManage modifyvm \"#{vm_name}\" --nictype1 Am79C970A --nic1 nat"
end

task :vbox_launch => :vbox_build do
  sh "VBoxManage startvm \"#{vm_name}\""
end

task :build_image => disk_image
task :default => :vbox_build
