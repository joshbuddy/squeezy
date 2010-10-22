require 'jars/yuicompressor-2.3.6.jar'
require 'squeezy/reporter'
require 'squeezy/compressor'
require 'squeezy/service'
require 'squeezy/version'

class Squeezy
  include Java
  
  def self.run_service
    Squeezy::Service.run!
  end
end
