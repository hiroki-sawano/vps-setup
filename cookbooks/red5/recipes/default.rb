#
# Cookbook Name:: red5
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package %w(java-1.8.0-openjdk unzip wget vim git expect) do
  action :install
end

group 'red5' do
  group_name 'red5'
  action :create
end

red5_home = "/home/red5"

user 'red5' do
  manage_home true
  group 'red5'
  home "#{red5_home}" 
  shell '/bin/bash'
  #password '$1$Uc75MVvV$6eXsMI41mi1g6xZI0HEum'
  action :create
end

remote_file "#{red5_home}/red5-server-1.0.5-RELEASE-server.tar.gz" do
  source 'https://github.com/Red5/red5-server/releases/download/v1.0.5-RELEASE/red5-server-1.0.5-RELEASE-server.tar.gz'
  owner 'red5'
  group 'red5'
  mode '0644'
end

bash 'unzip glassfish' do
  user 'red5'
  group 'red5'
  cwd "#{red5_home}"
  code <<-EOC
    tar zxf red5-server-1.0.5-RELEASE-server.tar.gz
    mv red5-server-1.0.5-RELEASE red5
    rm -f red5-server-1.0.5-RELEASE-server.tar.gz
  EOC
  not_if { File.exists?("#{red5_home}/red5/red5-service.jar")}
end

cookbook_file '/etc/systemd/system/red5.service' do
  source 'red5.service'
  owner 'root'
  group 'root'
  mode '0644'
  action :create_if_missing
end

service 'red5' do
  action [ :enable, :start ]
  supports :start => true, :stop => true
end
