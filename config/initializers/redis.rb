# when on heorku use environmemt variables, development use config/redis.yml
def redis_conf
  File.join Rails.root, 'config/redis.yml'
end

if ENV['REDISCLOUD_URL']
  uri = URI.parse(ENV['REDISCLOUD_URL'])
  Redisable::Config.load(host: uri.host, port: uri.port, password: uri.password)
else
  raise RuntimeError, "could not find config/redis.yml" unless File.exists?(redis_conf)
  Redisable::Config.load(YAML.load_file(redis_conf)["development"])
end

