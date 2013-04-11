# Redis settings
# when on heorku using environmemt variables, development use config/redis.yml
if ENV['REDISTOGO_URL']
  uri = URI.parse(ENV['REDISTOGO_URL'])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  raise RuntimeError, "could not find config/redis.yml" unless File.exists?(Rails.root + 'config/redis.yml')
  config = YAML.load_file(Rails.root + 'config/redis.yml')
  $redis = Redis.new(:host => config.host, :port => config.port)
end

