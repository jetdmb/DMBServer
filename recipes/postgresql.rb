  

root_password = node["dmbserver"]["db_root_password"]
if root_password
  node.set["postgresql"]["password"]["postgres"] = root_password
end

pg_version = node[:dmbserver][:pg_version]
if pg_version
  node.set["postgresql"]["enable_pgdg_apt"] = true
  node.set["postgresql"]["version"] = pg_version
  node.set["postgresql"]["server"]["packages"] = ["postgresql-#{pg_version}", "postgresql-server-dev-#{pg_version}"]
  node.set["postgresql"]["client"]["packages"] = ["postgresql-client-#{pg_version}"]
  node.set["postgresql"]["contrib"]["packages"] = ["postgresql-contrib-#{pg_version}"]
  node.set['postgresql']['dir'] = "/etc/postgresql/#{pg_version}/main"
  node.set['postgresql']['config']['data_directory'] = "/var/lib/postgresql/#{pg_version}/main"
end

node.set['postgresql']['pg_hba'] = [
  {:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'ident'},
  {:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '0.0.0.0/0', :method => 'md5'}
]

include_recipe "postgresql::server"

include_recipe "database::postgresql"


postgresql_connection_info = {
  :host => "localhost",
  :port => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

node["dmbserver"]["databases"]["postgresql"].each do |entry|

  postgresql_database entry["database_name"] do
    connection postgresql_connection_info
    template entry["template"] if entry["template"]
    encoding entry["encoding"] if entry["encoding"]
    collation entry["collation"] if entry["collation"]
    connection_limit entry["connection_limit"] if entry["connection_limit"]
    owner entry["owner"] if entry["owner"]
    action :create
  end

  postgresql_database_user entry["username"] do
    connection postgresql_connection_info
    action [:create, :grant]
    password(entry["password"])           if entry["password"]
    database_name(entry["database_name"]) if entry["database_name"]
    privileges(entry["privileges"])       if entry["privileges"]
  end

end