require 'bundler/setup'
require 'sinatra'
require 'active_record'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])


class Uxser < ActiveRecord::Base
end

class Tarot < ActiveRecord::Base
end

get '/' do
    Uxser.find(8).name
end

get '/bb' do
    "aaasss"
end

get '/aaa' do
    erb :index
end