## Start Up Steps
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
