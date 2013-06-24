##New Relic Setup

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

