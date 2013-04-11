#
# Cookbook Name:: jubatus
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

group node["jubatus"]["group"] do
      group_name node["jubatus"]["group"]
      action     [:create]
end

user node["jubatus"]["user"] do
     group node["jubatus"]["user"]
     home     "/home/"+node["jubatus"]["user"]
     shell "/bin/bash"
     password node["jubatus"]["password"]
     supports :manage_home => true
end


case node["platform"]
when "ubuntu"
  template "jubatus.list" do
    source "jubatus.list.erb"
    path   "/etc/apt/sources.list.d/jubatus.list"
  end

  execute "apt-get update" do
      command "apt-get update"
  end

  package "jubatus" do
    action :install
    options "--force-yes"
  end




## FIXME not checked
when "centos"

  bash "add jubatus repository" do
    user "root"
    code <<-EOC
      rpm -Uvh http://download.jubat.us/yum/rhel/6/stable/x86_64/jubatus-release-6-1.el6.x86_64.rpm
    EOC
    not_if File.exists?("/opt/jubatus/profile")
  end

  package "jubatus" do
    action :install
    not_if File.exists?("/opt/jubatus/profile")
  end

  package "jubatus-client" do 
    action :install
    not_if File.exists?("/opt/jubatus/profile")
  end

end

bash "add source to bashrs" do
     code <<-EOC
       echo "source /opt/jubatus/profile" >> /home/#{node["jubatus"]["user"]}/.bashrc
     EOC
end
