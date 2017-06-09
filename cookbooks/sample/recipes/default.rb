#
# Cookbook Name:: sample
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "java-1.8.0-openjdk" do
  action :install
end

package "unzip" do
  action :install
end

package "wget" do
  action :install
end

group 'glassfish' do
  group_name 'glassfish'
  action :create
end

user 'glassfish' do
  manage_home true
  group 'glassfish'
  home '/home/glassfish'
  shell '/bin/bash'
  password 'password'
  action :create
end

remote_file '/home/glassfish/glassfish-4.1.zip' do
  source 'http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip'
  owner 'glassfish'
  group 'glassfish'
  mode '0644'
end
