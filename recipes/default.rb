#
# Cookbook:: nexus
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

java_version = node['nexus']['rhel_java_version']
nexus_version = node['nexus']['version']

package java_version

user 'nexus'

remote_file "/opt/#{nexus_version}-unix.tar.gz" do
  source "https://download.sonatype.com/nexus/3/#{nexus_version}-unix.tar.gz"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  not_if { File.exist?("/opt/#{nexus_version}-unix.tar.gz") }
end

execute "extract nexus #{nexus_version}" do
  command "tar xzvf /opt/#{nexus_version}-unix.tar.gz && mv #{nexus_version} nexus"
  cwd '/opt'
  not_if { File.exists?('/opt/nexus') }
end

file '/opt/nexus/bin/nexus.rc' do
  content 'run_as_user="nexus"'
end

execute 'change ownership nexus' do
    command 'chown -R nexus /opt/nexus'
    not_if 'stat -c %U /opt/nexus | grep nexus'
end

execute 'change ownership sonatype-work' do
    command 'chown -R nexus /opt/sonatype-work'
    not_if 'stat -c %U /opt/sonatype-work | grep nexus'
end

template '/etc/systemd/system/nexus.service' do
    source 'nexus.service.erb'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

service 'nexus' do
    action [ :enable, :start ]
end