execute "apt-get update" do
  command "apt-get update"
end

execute "apt-get upgrade" do
  command "apt-get upgrade"
end

package "apache2" do #Instalamos apache
  action :install
end

service "apache2" do #Lanzamos apache
  action [:enable, :start]
end

package "mysql-server"

package 'python3'

execute "export LC_ALL=C" do
  command "export LC_ALL=C"
end

package "git"

package "php"
