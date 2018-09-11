cookbook_file '/opt/jdk-6u45-linux-x64.bin' do
  source 'jdk-6u45-linux-x64.bin'
  action :create
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
