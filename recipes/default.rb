#
# Cookbook Name:: ubuntu_shorewall
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

apt_package 'ufw' do
  action :purge
end

include_recipe 'shorewall_reloaded::default'

execute "/sbin/shorewall update /etc/shorewall"

service 'shorewall' do
  action [:start, :enable]
end
