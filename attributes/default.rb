default[:dmbserver][:enable_appbox] = false

default[:dmbserver][:enable_nodejs] = true
default[:dmbserver][:enable_postgresql] = true
default[:dmbserver][:enable_mysql] = true
default[:dmbserver][:enable_golang] = true
default[:dmbserver][:enable_ruby_tool] = true
default[:dmbserver][:enable_mongodb] = true
default[:dbmserver][:use_ubuntu_mirror] = true

default[:dbmserver][:install_rubies] = false


default[:dmbserver][:vagrant] = true

default[:dmbserver][:timezone] = "Asia/Shanghai"

default[:dmbserver][:ruby][:install_tool] = "rvm"
default[:dmbserver][:ruby][:versions] = %w(2.1.0)
default[:dmbserver][:ruby][:global_version] = "2.1.0"

default[:dmbserver][:nodejs][:versions] = %w(v0.10.24)
default[:dmbserver][:nodejs][:default_version] = "v0.10.24"


default[:dmbserver][:db_root_password] = "123456"
default[:dmbserver][:pg_version] = "9.3"
default[:dmbserver][:databases][:postgresql] = [
 	{  
 		:username => "nodejs",
    :password => "123456",
    :database_name => "nodejs_db" 
  },
  {
  	:username => "rails",
    :password => "123456",
    :database_name => "rails_db" 
  }
]

default[:dmbserver][:golang][:version] = "1.2" 
default[:dmbserver][:golang][:packages] = ["github.com/robfig/revel/revel"]

default[:mysql][:server_root_password] = "123456"
default[:mysql][:server_repl_password] = "123456"
default[:mysql][:server_debian_password] = "123456"

default[:rbenv][:root_path] = "/usr/local/rbenv"
default[:rvm][:global_gems] = []
default[:rvm][:user_global_gems] = []


default[:dmbserver][:mongodb][:dbpath] = "/var/lib/mongodb"
default[:dmbserver][:mongodb][:logpath] = "/var/log/mongodb"