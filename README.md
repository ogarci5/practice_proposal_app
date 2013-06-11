###Start Up Steps
#####Redis and Resque
Modify `Gemfile` to include 'resque' gem and 'resque-scheduler' gem
```ruby
gem 'resque'
```
Install gems

	$ bundle install
Install 'redis'

	$ brew install redis
Run redis server 

	$ redis-server
Redis is running on port 6379

Setup config file for resque in `/config/initializers/resque.rb` with local redis server config
```ruby
Resque.redis = 'localhost:6379'
Resque.redis.namespace = "resque:ResqueApp"

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }
```
Jobs created should be in `app/jobs/`:
```ruby
#Example: /app/jobs/myjob.rb

module MyJob
  @queue = :default
  def self.perform(params)
   	puts "Doing my job"
		puts params
  end
end
```
Make the resque tasks available to rake and set default environment variables.

Add to `Rakefile`
```ruby
require 'resque/tasks'
```
Set the default queue environment variable: `/lib/tasks/resque.rake`:
```ruby
require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end
```
Make sure PostgreSQL is installed and create the rack user

	$ psql
	> CREATE ROLE rack WITH SUPERUSER LOGIN;
	> \q
Create rails databases and run migrations

	$ rake db:create:all
	$ rake db:migrate

Start the scheduler: 

	$ rake resque:work
Call the job by running
```ruby
Resque.enqueue(MyJob, params)
```

#####Jenkins

#####New Relic
Create an account on [New Relic](http://newrelic.com/).  
Follow the steps outlined by New Relic.
Add the new relic gem to the `Gemfile`:
```ruby
gem 'newrelic_rpm'
```
Install the new gem:

	$ bundle install
Add the `newrelic.yml` file provided by New Relic to `config/`  
Restart the server.

#####Ubuntu Redis Configuration
Edit the init script:

	$ nano /etc/init.d/redis_6379
Make sure to modify REDIS_PORT accordingly to the port you are using. Both the pid file path and the configuration file name depend on the port number.  
Copy the template configuration file you'll find in the root directory of the Redis distribution into `/etc/redis/` using the port number as name:

	$ cp redis.conf /etc/redis/6379.conf
Create a directory inside /var/redis that will work as data and working directory for this Redis instance:

	$ mkdir /var/redis/6379
Edit the configuration file, making sure to perform the following changes:

- Set daemonize to yes (by default it is set to no).
- Set the pidfile to /var/run/redis_6379.pid (modify the port if needed).
- Change the port accordingly. In our example it is not needed as the default port is already 6379.
- Set your preferred loglevel.
- Set the logfile to /var/log/redis_6379.log
- Set the dir to /var/redis/6379 (very important step!)

Finally add the new Redis init script to all the default runlevels using the following command:

	$ sudo update-rc.d redis_6379 defaults
You are done! Now you can try running your instance with:

	$ /etc/init.d/redis_6379 start
