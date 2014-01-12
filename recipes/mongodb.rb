include_recipe "mongodb::default"

mongodb_instance "mongodb" do
  dbpath node[:dmbserver][:mongodb][:dbpath]
  logpath node[:dmbserver][:mongodb][:logpath]
end