cookbook_file '/opt/jdk-6u45-linux-x64.bin' do
  source 'jdk-6u45-linux-x64.bin'
  action :create
end

cookbook_file '/opt/jboss-eap-5.1.2.zip' do
  source 'jboss-eap-5.1.2.zip'
  action :create
end

package 'unzip' do
  action :install
end

bash 'installing java' do
  code <<-EOH
    chmod +x /opt/jdk-6u45-linux-x64.bin && cd /opt
    ./jdk-6u45-linux-x64.bin
    EOH
end

bash 'setting up java' do
  code <<-EOH 
    alternatives --install /usr/bin/java java /opt/jdk1.6.0_45/bin/java 1000
    alternatives --install /usr/bin/javac javac /opt/jdk1.6.0_45/bin/javac 1000
    alternatives --install /usr/bin/jar jar /opt/jdk1.6.0_45/bin/jar 1000
    EOH
end

bash 'installing jboss' do
  code <<-EOH
    cd /opt && unzip jboss-eap-5.1.2.zip
    EOH
end

execute 'running jboss' do
  command 'nohup /opt/jboss-eap-5.1/jboss-as/bin/run.sh -b 192.168.50.100 &'
end

directory '/opt/projects/hello/WEB-INF' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

file '/opt/projects/hello/hi.jsp' do
  content '<!doctype html> <html lang=en> <head> <title>JSP Test</title> <%! String message = "Hello, World."; %> </head> <body> <h2><%= message%></h2> <%= new java.util.Date() %> </body> </html>'
  mode '0644'
  owner 'root'
  group 'root'
end

file '/opt/projects/hello/WEB-INF/web.xml' do
  content '<web-app> <display-name>Hello World</display-name> </web-app>'
  mode '0644'
  owner 'root'
  group 'root'
end

bash 'creating a war file' do
  code <<-EOH
    cd /opt/projects/hello
    jar -cvf helloworld.war *.jsp WEB-INF
    cp helloworld.war /opt/jboss-eap-5.1/jboss-as/server/default/deploy/
    EOH
end
