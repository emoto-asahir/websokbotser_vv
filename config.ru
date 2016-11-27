require 'bundler'
require 'active_record'
Bundler.require


require './app'
use ActiveRecord::ConnectionAdapters::ConnectionManagement
run Sinatra::Application