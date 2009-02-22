require 'lib/squeezy'

$base_dir = ARGV[0]

set :reload, false
set :environment, :production

Sinatra::Base.run!