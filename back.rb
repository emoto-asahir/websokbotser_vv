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
          # ws.send({ you: ws.object_id }.to_json)
        end

        ws.on :message do |event|
          p [:message, event.data]
          mystr = event.data
          json = {:key_a => "value2", :key_b => "value3"}.to_json
          p json
          JSON.parse(json)
          
          p "www"
          
          vvv = JSON.parse("sssaaaa") rescue nil
          
          p vvv
          
          vvv = JSON.parse(event.data) rescue nil
          
          p vvv
          
          msghash = nil
          p "xxxxx"
          output = {}
          output = { "text" => Uxser.find(8).name , "type" => "message" , "success" => false }
          
          msghash = JSON.parse(event.data) rescue nil
          p "vvvv"
          p msghash
          if msghash
            p msghash["text"]
            p "aaghh"
            msghash["text"] =~ /^(@bot|bot(:|\s|\p{blank}))/
            p "vvvvvv"
            p (msghash["text"] =~ /^(@bot|bot(:|\s|\p{blank}))/)
            p "qqqqq"
            isment = (msghash["text"] =~ /^(@bot|bot(:|\s|\p{blank}))/)
            p isment
            p "wwwwuuuu"
            output["text"] = msghash["text"]
            output["success"] = true
          end
          
          p "ffff"
          str = JSON.generate(output)
          p "sswww"
          @clients.each { |client| 
          
            client.send str
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