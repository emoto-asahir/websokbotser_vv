require 'bundler/setup'
require 'sinatra'
require 'active_record'
class Student < ActiveRecord::Base
    
end
get '/' do
    "aaaaaa"
end