require "rubygems"
require "bundler"
Bundler.setup
$: << File.join(File.dirname(__FILE__), 'lib')
require 'squeezy'
require 'sinatra'

set :reload, false
set :environment, :production

squeezy = Squeezy.new

put('/js') do
  squeezy.compress_js(request.env['rack.input'].read)
end

put('/css') do
  squeezy.compress_css(request.env['rack.input'].read)
end
