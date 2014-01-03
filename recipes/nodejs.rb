include_recipe "nvm"

default_version = node[:dmbserver][:nodejs][:default_version]

node[:dmbserver][:nodejs][:versions].each do |version|

  nvm_install version  do
		from_source false
		alias_as_default true if default_version = version
		action :create
	end

end