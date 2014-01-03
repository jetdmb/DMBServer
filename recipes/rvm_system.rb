# start chef-rvm system recipe
include_recipe "rvm::system_install"

if platform?("ubuntu")
	execute "set ruby mirror" do 
		command "sed -i 's!cache.ruby-lang.org/pub/ruby!ruby.taobao.org/mirrors/ruby!' #{node[:rvm][:root_path]}/config/db"
		only_if %{type rvm | cat | head -1 | grep -q '^rvm is a function$'}
	end
end

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