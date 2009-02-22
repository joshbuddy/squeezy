$:.unshift File.dirname(__FILE__)

require 'sinatra'
require 'squeezy/reporter'
require 'squeezy/compressor'

post('/js') do
  compress_js(@request.env['rack.request.form_vars'])
end

post('/css') do
  compress_css(@request.env['rack.request.form_vars'])
end

get('*') do
  asset = File.join($base_dir,  @request.env['PATH_INFO'])
  if File.exists?(asset)
    out = File.open(asset) do |f|
      case File.extname(asset)
      when '.css'
        headers 'Content-type' => 'text/css'
        compress_css(f.read)
      when '.js'
        headers 'Content-type' => 'text/javascript'
        compress_js(f.read)
      end
    end
    out

  end
end


