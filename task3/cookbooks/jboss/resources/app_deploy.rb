resource_name :app_deploy

property :version, String, default: '1.0.0'
property :app_name, String, default: 'SimpleWebApp.war'
property :path, String, default: node['jboss']['path']

default_action :create

load_current_value do
  version
end

action :create do
  if (new_resource.version != current_resource.version)
    cookbook_file "#{new_resource.path}#{new_resource.app_name}" do
      source new_resource.app_name
      action :create
    end
  end
end
