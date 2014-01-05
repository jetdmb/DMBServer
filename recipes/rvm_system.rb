# start chef-rvm system recipe
include_recipe "rvm::system_install"

if platform?("ubuntu")
  command_text = "sed -i 's!cache.ruby-lang.org/pub/ruby!ruby.taobao.org/mirrors/ruby!' #{node[:rvm][:root_path]}/config/db"
  Chef::Log.info "command_text : #{command_text}" 
  execute "set ruby mirror" do 
    command command_text
  end
end

node.set[:rvm][:install_rubies] = node[:dbmserver][:install_rubies]

perform_install_rubies  = node['rvm']['install_rubies'] == true ||
                  node['rvm']['install_rubies'] == "true"

if perform_install_rubies
  install_rubies  :rubies => node['rvm']['rubies'],
                  :default_ruby => node['rvm']['default_ruby'],
                  :global_gems => node['rvm']['global_gems'],
                  :gems => node['rvm']['gems']
end


# add users to rvm group
group 'rvm' do
  members node['rvm']['group_users']

  only_if { node['rvm']['group_users'].any? }
end

# end chef-rvm system recipe