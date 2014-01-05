
if node["dmbserver"]["ruby"]["versions"]
  node.set["rvm"]["rubies"] = node["dmbserver"]["ruby"]["versions"]
end 

if node["dmbserver"]["ruby"]["global_version"] 
  node.set["rvm"]["default_ruby"] = node["dmbserver"]["ruby"]["global_version"] 
  node.set["rvm"]["user_default_ruby"] = node["dmbserver"]["ruby"]["global_version"] 
end

if node["dmbserver"]["vagrant"]
  ruby_block "get chef-solo path" do
    block do
      Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)      
      curl_command = 'which chef-solo' 
      curl_command_out = shell_out(curl_command)
      chef_solo_path = curl_command_out.stdout
      Chef::Log.info "curl_command chef_solo_path : #{curl_command_out.stdout}"
      if chef_solo_path
        Chef::Log.info "chef_solo_path : #{chef_solo_path}"
        node.set["rvm"]["vagrant"]['system_chef_solo'] = chef_solo_path.strip
      end

      curl_command = 'which chef-client' 
      curl_command_out = shell_out(curl_command)
      chef_solo_path = curl_command_out.stdout
      Chef::Log.info "curl_command chef_client_path : #{curl_command_out.stdout}"
      if chef_solo_path
        Chef::Log.info "chef_chef_client : #{chef_solo_path}"
        node.set["rvm"]["vagrant"]['system_chef_client'] = chef_solo_path.strip
      end
    end
    action :create
  end
  #Chef::Log.info "chef-solo path : #{node["rvm"]["vagrant"]['system_chef_solo']}"
  #node.set["rvm"]["vagrant"]['system_chef_solo'] = '/usr/bin/chef-solo' 
  include_recipe "rvm::vagrant"
end

include_recipe "rvm::default"
include_recipe "dmbserver::rvm_system"
