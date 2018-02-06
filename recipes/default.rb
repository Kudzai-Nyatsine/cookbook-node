#
# Cookbook:: node
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update

#install NGINX
package 'nginx'

#Restart Nginx
service "nginx" do
	action [:enable, :start]
end
#create template
template '/etc/nginx/sites-available/default' do
	source 'proxy.conf.erb'
	owner 'root'
	group 'root'
	mode '0750'
	notifies :reload , "service[nginx]"
end
#install node js

remote_file '/tmp/nodesource_setup.sh' do
	source 'https://deb.nodesource.com/setup_6.x'
	action :create
end

execute "update node resources" do
	command "sh /tmp/nodesource_setup.sh"
end

package 'nodejs' do
	action :upgrade
end