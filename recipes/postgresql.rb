pg_version = node[:dmbserver][:pg_version]
if pg_version
  node.set["postgresql"]["version"] = pg_version
end

node.set['postgresql']['pg_hba'] = [
  {:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'ident'},
  {:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '0.0.0.0/0', :method => 'md5'}
]



include_recipe "postgresql::server"


root_password = node["dmbserver"]["db_root_password"]
if root_password
  pg_user "postgres" do
    privileges superuser: true, createdb: true, login: true
    password root_password
  end
end

node["dmbserver"]["databases"]["postgresql"].each do |entry|

  pg_user entry["username"] do
    privileges superuser: false, createdb: true, login: true
    password entry["password"]
  end

  pg_database entry["database_name"] do
    owner entry["username"]
    encoding( entry["encoding"] || "utf8" )
    template(entry["template"] || "template0")
    locale "en_US.UTF8"
  end

end