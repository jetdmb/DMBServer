#
# Cookbook Name:: dmbserver
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#
node.set['build_essential']['compiletime'] = true
include_recipe "build-essential::default"


if node[:dmbserver][:timezone]
	include_recipe "dmbserver::timezone"
end

include_recipe "dmbserver::apt"

if node[:dmbserver][:enable_ruby]
	include_recipe "dmbserver::ruby"
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