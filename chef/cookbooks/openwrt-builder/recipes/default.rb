#
# Cookbook Name:: openwrt-builder
# Recipe:: default
#
# Copyright 2012, Jon Williams
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# runtime deps
%w{ git build-essential subversion libncurses5-dev zlib1g-dev gawk flex libssl-dev unzip }.each do |pkg|
  package pkg do
    action :install
  end
end

dir = "/mnt/openwrt"
directory dir do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
end

execute "git clone http://git.mirror.nanl.de/openwrt/trunk.git ." do
  action :run
  user "vagrant"
  group "vagrant"
  cwd dir
  creates "#{dir}/.git"
end

execute "./scripts/feeds update -a" do
  action :run
  user "vagrant"
  group "vagrant"
  cwd "#{dir}"
end

execute "make defconfig && make prereq" do
  action :run
  user "vagrant"
  group "vagrant"
  cwd "#{dir}"
end

template "#{dir}/.config" do
  source "openwrt.config.erb"
  mode 0660
  owner "vagrant"
  group "vagrant"
  variables({
  })
end

execute "make " do # todo add a -j option?
  action :run
  user "vagrant"
  group "vagrant"
  cwd "#{dir}"
end

link "/home/vagrant/openwrt" do
  to dir
end
