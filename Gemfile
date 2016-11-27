source "https://rubygems.org"

gem 'sinatra'
gem "activerecord", "< 5.0.0"
gem 'sinatra-activerecord'
gem 'rake'
gem "faye-websocket"
gem "puma"

group :development, :test do
  gem 'foreman'
  gem 'sqlite3'
end 

group :production do
  gem 'pg'
end
