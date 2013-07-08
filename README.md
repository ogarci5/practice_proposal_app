###Start Up Steps

####Redis and Resque

[Make sure you have installed and configured Redis and Resque. See REDIS_INSTALL.md and RESQUE_INSTALL.md]

Run redis server: 

	$ redis-server

Start a Resque worker:

	$ QUEUE=*  rake resque:work


####Jenkins

You don't need to start Jenkins to run your app. To setup and start Jenkins, see app/doc/JENKINS_INSTALL.md 

####New Relic
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
Go to https://rpm.newrelic.com/accounts/349165/applications/2127803
Steps from http://redis.io/topics/quickstart


#### Rails

To start the default server in production modesdf'lksdflk

	$ bundle exec s -e production