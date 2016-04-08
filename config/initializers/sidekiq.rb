redisServer = "localhost"
Sidekiq.configure_server do |config|
  config.redis = { :url => 'redis://' + redisServer + ':6379/0' }
end