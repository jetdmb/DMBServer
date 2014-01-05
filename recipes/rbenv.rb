if node["dmbserver"]["vagrant"]
  ruby_block "get chef-solo path" do
    block do
      Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)      
      curl_command = 'which chef-solo' 
      curl_command_out = shell_out(curl_command)
      chef_solo_path = curl_command_out.stdout
      Chef::Log.info "curl_command chef_solo_path : #{curl_command_out.stdout}"
      if chef_solo_path
        node.set["rbenv"]["vagrant"]['system_chef_solo'] = chef_solo_path.strip
      end

    end
    action :create
  end
end

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

if platform?("ubuntu")
  execute "set ruby mirror for rbenv" do 
    command "find #{node['rbenv']['root_path']}/plugins/ruby_build/share/ruby-build/ -type f -print0 | xargs -0 sed -i 's!cache.ruby-lang.org/pub/ruby!ruby.taobao.org/mirrors/ruby!'"
  end
end
if node[:dbmserver][:install_rubies]
  node["dmbserver"]["ruby"]["versions"].each do |rb_version|
    
    rbenv_ruby rb_version do
      global(node["dmbserver"]["ruby"]["global_version"] == rb_version)
    end

    rbenv_gem "bundler" do
      ruby_version rb_version
    end
  end
end