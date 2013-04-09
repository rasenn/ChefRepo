#
# Cookbook Name:: ssh_nopass
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


package "openssh-server" do
	action :install
	not_if { File.exists?('/etc/init.d/ssh') }
end

package "openssh-client" do 
	action :install 
	not_if { File.exists?('/usr/bin/ssh') }
end


if node["ssh"] && node["ssh"]["user"] 
  directory "/home/"+node["ssh"]["user"]+"/.ssh" do 
    owner node["ssh"]["user"] 
    group node["ssh"]["group"] if node["ssh"]["group"] 
    mode 0755
    action :create
    not_if { File.exists?('/home/'+node["ssh"]["user"] +'/.ssh') }
  end

  bash "generate ssh key" do
     user node["ssh"]["user"] 
     code <<-EOC
          ssh-keygen -N '' -f '/home/#{node["ssh"]["user"]}/.ssh/id_rsa' 
     EOC
     not_if { File.exists?('/home/'+node["ssh"]["user"] +'/.ssh/id_rsa') }
  end

end



