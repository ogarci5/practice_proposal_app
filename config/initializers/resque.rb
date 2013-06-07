Resque.redis = 'localhost:6379'
Resque.redis.namespace = "resque:ResqueApp"

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }