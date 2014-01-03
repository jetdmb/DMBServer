go_version = node[:dmbserver][:golang][:version]
node.set[:go][:version] = go_version if go_version

go_packages = node[:dmbserver][:golang][:packages]
node.set[:go][:packages] = go_packages if go_packages

include_recipe "golang::packages"