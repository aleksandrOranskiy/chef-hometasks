url = "https://nginx.org/packages/centos/7/x86_64/RPMS/nginx-#{node['nginx']['version']}-1.el7.ngx.x86_64.rpm"
file = "nginx-#{node['nginx']['version']}-1.el7.ngx.x86_64.rpm"

remote_file "/tmp/#{file}" do
  source url
  action :create_if_missing
end

package file do
  source "/tmp/#{file}"
  action :install
end

service "nginx" do
  action [:enable, :start]
end

directory "/var/www/#{node['nginx']['app_dest']}" do
  recursive true
  action :create
end

content = data_bag_item('landing', 'simple')

template "/var/www/#{node['nginx']['app_dest']}/index.html" do   
  source "index.html.erb"
  mode "0644"
  action :create
  variables( ct: content )
  notifies :reload, "service[nginx]"
end

ip = ''
search(:node, 'role:jboss',
  :filter_result => { 'ip' => [ 'ipaddress' ]}
      ).each do |result|
  ip = result['ip']
end

template "/etc/nginx/nginx.conf" do   
  source "nginx.conf.erb"
  variables(
    ip_address: ip,
    port: node['nginx']['port'],
    app_dest: node['nginx']['app_dest'] 
  )
  notifies :reload, "service[nginx]"
end
