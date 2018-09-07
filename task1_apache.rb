package 'httpd' do
  action :install
end

service 'httpd' do
  action [:enable, :start]
end

package 'php' do
  action :install
  notifies :restart, "service[httpd]"
end

file '/var/www/html/info.php' do
  content '<?php phpinfo(); ?>'
  mode '0644'
  owner 'root'
  group 'root'
end
