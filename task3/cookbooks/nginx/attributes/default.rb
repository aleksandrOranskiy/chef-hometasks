default['nginx']['version'] = '1.10.1'
default['nginx']['port'] = '80'
default['nginx']['root'] = 'html'
default['nginx']['url'] = "https://nginx.org/packages/centos/7/x86_64/RPMS/nginx-#{node['nginx']['version']}-1.el7.ngx.x86_64.rpm"
default['nginx']['file'] = "nginx-#{node['nginx']['version']}-1.el7.ngx.x86_64.rpm"
default['nginx']['data'] = Chef::DataBagItem.load('landing', 'simple')
