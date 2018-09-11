package 'unzip' do
  action :install
end

cookbook_file '/opt/jboss-eap-5.1.2.zip' do
  source 'jboss-eap-5.1.2.zip'
  action :create
end

bash 'installing jboss' do
  code <<-EOH
    cd /opt && unzip jboss-eap-5.1.2.zip
    EOH
  not_if { ::File.exist?("#{node['jboss']['jboss_home']}")}
end

systemd_unit 'jboss.service' do 
  content <<-EOU
  [Unit]
  Description=Jboss Application Server
  After=network.target
  [Service]
  Type=forking
  User=#{node['jboss']['user']}
  ExecStart=/bin/bash -c "nohup /opt/jboss-eap-5.1/jboss-as/bin/run.sh -b #{node['jboss']['ip']} &"
  [Install]
  WantedBy=multi-user.target
  EOU
  action [ :create, :enable, :start ]
end

app_deploy 'custom_deploy' do
  version '1.0.1'
  action :create
end