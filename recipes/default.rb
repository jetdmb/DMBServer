#
# Cookbook Name:: dmbserver
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#
include_recipe "dmbserver::apt"

if node[:dmbserver][:timezone]
	include_recipe "dmbserver::timezone"
end

node.set['build_essential']['compiletime'] = true
include_recipe "build-essential::default"

if node[:dmbserver][:enable_ruby_tool]
	if node[:dmbserver][:ruby][:install_tool] == "rvm"
		include_recipe "dmbserver::rvm"
	else
		include_recipe "dmbserver::rbenv"	
	end
end

if node[:dmbserver][:enable_appbox]
	include_recipe "appbox::default"
end

if node[:dmbserver][:enable_nodejs]
	include_recipe "dmbserver::nodejs"
end

if node[:dmbserver][:enable_mysql]
	include_recipe "dmbserver::mysql"
end

if node[:dmbserver][:enable_golang]
	include_recipe "dmbserver::golang"
end

if node[:dmbserver][:enable_postgresql]
	include_recipe "dmbserver::postgresql"
end

if node[:dmbserver][:enable_mongodb]
	include_recipe "dmbserver::mongodb"
end

