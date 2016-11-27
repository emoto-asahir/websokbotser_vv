require 'bundler'
require 'active_record'
Bundler.require


require './app'
require './back'

use ActiveRecord::ConnectionAdapters::ConnectionManagement
use Websockettest2::Backend
run Sinatra::Application