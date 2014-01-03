package "tzdata" do
  action :install
end

bash "update-tzdata" do
  user 'root'
  code "dpkg-reconfigure -f noninteractive tzdata"
  action :nothing
end

file "/etc/timezone" do
  owner "root"
  group "root"
  mode "0644"
  content node[:dmbserver][:timezone]
  notifies :run, "bash[update-tzdata]"
end
