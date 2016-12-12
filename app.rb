require 'bundler/setup'
require 'sinatra'
require 'active_record'


ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])


get '/' do
    "aasssvv"
end

get '/bb' do
    "aaasss"
end

get '/aaa' do
    erb :index
end