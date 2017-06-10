#
# Cookbook Name:: sample
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package %w(java-1.8.0-openjdk unzip wget vim git) do
  action :install
end

user 'hiroki.sawano' do
  manage_home true
  group 'wheel'
  home '/home/hiroki.sawano'
  shell '/bin/bash'
#  password 'password'
  action :create
end
 
group 'glassfish' do
  group_name 'glassfish'
  action :create
end

glassfish_home = "/home/glassfish"

user 'glassfish' do
  manage_home true
  group 'glassfish'
  home "#{glassfish_home}" 
  shell '/bin/bash'
#  password 'password'
  action :create
end

remote_file "#{glassfish_home}/glassfish-4.1.zip" do
  source 'http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip'
  owner 'glassfish'
  group 'glassfish'
  mode '0644'
end

bash 'unzip glassfish' do
  user 'glassfish'
  group 'glassfish'
  cwd "#{glassfish_home}"
  code <<-EOC
    unzip glassfish-4.1.zip
    rm -f glassfish-4.1.zip 
  EOC
  not_if { File.exists?("#{glassfish_home}/glassfish4/glassfish/lib/client/appserver-cli.jar")}
end

cookbook_file '/etc/systemd/system/glassfish.service' do
  source 'glassfish.service'
  owner 'root'
  group 'root'
  mode '0644'
  action :create_if_missing
end

service 'glassfish' do
  action [ :enable, :start ]
  supports :start => true, :stop => true, :reload => true
end

# allow accessing admin console 
# asadmin change-admin-password
# asadmin enable-secure-admin
# asadmin stop-domain
# asadmin start-domain

# doesn't work?
git '/home/hiroki.sawano' do
   repository 'https://github.com/hiroki-sawano/vimrc.git'
   revision 'master'
   action :checkout
   user 'hiroki.sawano'
end
