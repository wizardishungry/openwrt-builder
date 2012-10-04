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

dir = "/mnt/openwrt/trunk/staging_dir"
directory dir do
  owner "root"
  group "root"
  mode "0755"
  action :create
end
mount dir do
  pass 0
  device "/dev/null"
  fstype "tmpfs"
  options "rw,nosuid,nodev,mode=777,size=1024m"
  action [:mount, :enable]
end
