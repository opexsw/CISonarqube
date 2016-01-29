# Cookbook Name:: CISonarqube
# Recipe:: default
# Copyright 2015, Opex Software,Pune
# All rights reserved - Do Not Redistribute

=begin
# PHP tools Recipe

include_recipe 'phpTools::default'

# Cookbook for php

include_recipe 'php'
=end

# Package required for mysql gem installation

package "libmysqlclient-dev" do
 action :install
end

# mysql gem for mysql server 

chef_gem "mysql2" do
 compile_time false if respond_to?(:compile_time)
 ignore_failure true
end

# Add Repository of SoanrQube Server

apt_repository 'sonarqube' do
  uri        'http://downloads.sourceforge.net/project/sonar-pkg/deb'
  components ['binary/']
end

# Update the package list

include_recipe 'apt'

# Java for SonarQube

package "openjdk-7-jdk" do
 action :install
end

# Install SonarQube Server

package "sonar" do
 options "--force-yes"
 action :install
end

template "/tmp/sqlcmds.sql" do
  source "sqlcmds.sql"
  mode "0755"
  owner "sonar"
end

# Defined SonarQube Service

service 'sonar' do
  supports :status => true, :restart => true, :reload => true
  action  :nothing
end

template "/opt/sonar/conf/sonar.properties" do
  source "sonar.properties"
  mode "600"
  owner "sonar"
  notifies :restart, 'service[sonar]', :immediately
end

execute "Run commands to set the database" do
  command "sudo /usr/bin/mysql -u root --password=password  mysql   < /tmp/sqlcmds.sql > /tmp/op"
  action :run
end