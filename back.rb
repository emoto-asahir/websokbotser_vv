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
          
          
          vvv = JSON.parse("sssaaaa") rescue nil
          
          
          vvv = JSON.parse(event.data) rescue nil
          
          
          msghash = nil
          output = {}
          output = { "text" => "kkkkk" , "type" => "message" , "success" => false }
          
          msghash = JSON.parse(event.data) rescue nil
          
          p msghash
          if msghash
            isment = (msghash["text"] =~ /^(@bot|bot(:|\s|\p{blank}))/)
            output["text"] = msghash["text"]
            output["success"] = true
          end
          
          str = JSON.generate(output)
          
          @clients.each { |client| 
          
            client.send str
          }
          
          if isment
            output["type"] = "bot"
            case msghash["text"]
            when /.*ping.*/
              output["text"] = "pong"
            when /.*tarot.*/
              tarot = Tarot.find(Tarot.pluck(:id).sample)
              itinum = [1,0].sample
              if itinum == 0
                iti = "正位置"
                coment = tarot.content
              else
                iti = "逆位置"
                coment = tarot.content2
              end
              output["text"] = "カード名" + tarot.name + ":" + iti + ":" + coment
            else
              output["text"] = "just mentioned"
            end
                
            str = JSON.generate(output)
            ws.send str
          end
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