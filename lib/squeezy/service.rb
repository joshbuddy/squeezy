require 'sinatra'

class Squeezy
  class Service < Sinatra::Base
    set :reload, false
    set :environment, :production

    squeezy = Squeezy.new

    get('/') do
      'ok'
    end

    put('/js') do
      begin
        js = request.env['rack.input'].read.force_encoding('utf-8')
        squeezy.compress_js(js)
      rescue => e
        halt 500, e.message
      end
    end

    put('/css') do
      begin
        css = request.env['rack.input'].read.force_encoding('utf-8')
        squeezy.compress_css(css)
      rescue => e
        halt 500, e.message
      end
    end
  end
end
