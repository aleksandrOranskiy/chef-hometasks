resource_name :nginx_install

property :version, String, default: node['nginx']['version'], required: true
property :port, String, default: node['nginx']['port']
property :url, String, default: node['nginx']['url']
property :file, String, default: node['nginx']['file']
property :content, DataBagItem, default: node['nginx']['data']
property :nginx_root, String, default: node['nginx']['root']

default_action :install


load_current_value do
  version
end

action :install do
  if (new_resource.version != current_resource.version)
    remote_file "/tmp/#{new_resource.file}" do
      source new_resource.url
      action :create
    end
    
    package new_resource.file do
      source "/tmp/#{new_resource.file}"
      action :install
    end

    service "nginx" do
      action [:enable, :start]
    end

    template "/usr/share/nginx/html/index.html" do   
      source "index.html.erb"
      mode "0644"
      action :create
      variables( ct: new_resource.content )
      notifies :reload, "service[nginx]"
    end

    template "/etc/nginx/conf.d/custom.conf" do   
      source "nginx.conf.erb"
      variables(
        ip_address: search(:node, 'roles:jboss')[0]["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first,
        self_ip: node["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first,
        port: new_resource.port,
        root: new_resource.nginx_root
      )
      notifies :reload, "service[nginx]"
    end
  end
end
