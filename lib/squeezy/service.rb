require 'sinatra'

class Squeezy
  class Service < Sinatra::Base
    set :reload, false
    set :environment, :production

    squeezy = Squeezy.new

    put('/js') do
      squeezy.compress_js(request.env['rack.input'].read)
    end

    put('/css') do
      squeezy.compress_css(request.env['rack.input'].read)
    end
  end
end