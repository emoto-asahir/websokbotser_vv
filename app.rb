require 'bundler/setup'
require 'sinatra'
require 'active_record'


ActiveRecord::Base.establish_connection(
 adapter: 'sqlite3',
 database: 'meido.sqlite3'
)



get '/' do
    "aasssvv"
end

get '/bb' do
    "aaasss"
end

get '/aaa' do
    erb :index
end