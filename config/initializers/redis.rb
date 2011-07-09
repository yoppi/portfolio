# Redis settings on localhost
uri = URI.parse(ENV['REDIS_TOGO'])
$redis = Redis.new(:host => uri.host, :port => uri.port)
