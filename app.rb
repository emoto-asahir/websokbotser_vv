require 'bundler/setup'
require 'sinatra'
require 'active_record'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

class Uzser < ActiveRecord::Base
end

get '/' do
    Uzser.find(8).name
end

get '/aaa' do
    erb :index
end