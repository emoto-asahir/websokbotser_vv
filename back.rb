require 'faye/websocket'
require 'json'
require './app'


module Websockettest2
  class Backend
    KEEPALIVE_TIME = 15
    MAX_LOG_SIZE = 50
    def initialize(app)
      @app = app
      @clients = []
      @logs = Array.new
    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        ws = Faye::WebSocket.new(env, nil, ping: KEEPALIVE_TIME)
        
        ws.on :open do |event|
          p [:open, ws.object_id]
          @clients << ws

        end

        ws.on :message do |event|
          p [:message, event.data]
          @clients.each { |client| 
            client.send event.data
          }
          @logs.push event.data
          @logs.shift if @logs.size > MAX_LOG_SIZE
        end

        ws.on :close do |event|
          p [:close, ws.object_id, event.code]
          @clients.delete(ws)

          ws = nil
        end
        ws.rack_response
      else
        @app.call(env)
      end
    end
  end
end