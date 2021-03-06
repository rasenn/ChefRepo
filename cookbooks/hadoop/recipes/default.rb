#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
file_path = "http://ftp.kddilabs.jp/infosystems/apache/hadoop/common/hadoop-1.0.4/hadoop-1.0.4.tar.gz"
file_name = "hadoop-1.0.4.tar.gz"
thawing_dir = "hadoop-1.0.4"

group "hadoop" do 
      group_name "hadoop"
      gid	 412
      action	 [:create]
end

user "hadoop" do
     uid      412
     group    "hadoop"
     home     "/home/hadoop"
     shell "/bin/bash"
     password node["hadoop"]["password"]
     supports :manage_home => true
end



bash "download hadoop-xxx.tar.gz" do 
#     not_if File.exists?("/usr/local/"+file_name)
     user  "root"
     group "root"
     cwd "/usr/local"
     code <<-EOC 
     	  curl -O #{file_path} 
     EOC
     creates "/usr/local/"+file_name
end

bash "set hadoop directory" do 
     user  "root"
     group "root"
     cwd "/usr/local"
     code <<-EOC 
     	  tar zxvf #{file_name}
	  chown -R hadoop:hadoop #{thawing_dir}
	  ln -s #{thawing_dir} hadoop
	  mkdir hadoop/datas
	  chown -R hadoop:hadoop #{thawing_dir}
	  chown -R hadoop:hadoop hadoop
     EOC
     only_if File.exists?(file_name) && !File.exists?("hadoop/datas")
end


template_files = ["core-site.xml","hadoop-env.sh","hdfs-site.xml","mapred-site.xml","masters","slaves"]
template_files.each do |temp|
  template temp do
    source temp+".erb"
    mode "0644"
    path "/usr/local/hadoop/conf/"+temp
  end
end

template "/etc/hosts" do
  user "root"
  path "/etc/hosts"
  source "hosts.erb"
  mode "0644"
end

#template "core-site.xml" do
#  source "core-site.xml.erb"
#  mode "0644"
#  path "/usr/local/hadoop/conf/core-site.xml"
#end

