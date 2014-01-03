if platform?("ubuntu") and node[:dbmserver][:use_ubuntu_mirror]
	template "/etc/apt/sources.list" do
	  source    "ubuntu_source_163.erb"
	  owner     "root"
	  group     "root"
	  mode      "0755"
	end
end

include_recipe "apt::default"