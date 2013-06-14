## Installing Resque

see the README at:  https://github.com/resque/resque
the README for the stable branch is also very helpful: https://github.com/resque/resque/tree/1-x-stable

#### Install Resque

ADD Resque to your project by putting the following lines in its Gemfile:

	gem 'resque'
	gem 'resque-scheduler'

Install the gems by running Bundler:

	$ bundle install

That's it! You can now create Resque jobs from within your app.

To start a worker, create a Rakefile in your app's root (or add this to an existing Rakefile):

	require 'your/app'
	require 'resque/tasks'

Now start the worker:

	$ QUEUE=* rake resque:work

To run redis server: 

	$ redis-server

Redis is now running on port 6379


#### Configure Resque

You must configure Resque to work with Redis. Add to the file `config/initializers/resque.rb` the following:

	# re-use the existing Redis Connection
	Resque.redis = 'localhost:6379'
	Resque.redis.namespace = "resque:ResqueApp"

	# 
	Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }


#### Running Resque

To start a worker, create a Rakefile in your app's root (or add this to an existing Rakefile):

	require 'your/app'
	require 'resque/tasks'

Now start the worker:

	$ QUEUE=* rake resque:work

To run redis server: 

	$ redis-server

Redis is now running on port 6379

Jobs created should be in `app/jobs/`:
```ruby


#####Example: /app/jobs/myjob.rb

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

Start the resque process: 

	$ rake resque:work

Call the job by running
```ruby
Resque.enqueue(MyJob, params)
```


#### Using the Resque web front end

Resque comes with a Sinatra-based front end for seeing what's up with your queue. 

If you've installed Resque as a gem running the front end standalone is easy:

	$ resque-web -p xxxx

Where `xxxx` is the port on which you'd like to view redis.




