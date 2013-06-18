### RSPEC Setup

Add to the project Gemfile: 

	group :development, :test do
		gem 'rspec-rails', '2.11.0'
		gem 'factory_girl_rails', '4.1.0'
	end
	
Prepare test database:

$ bundle exec rake db:test:prepare RAILS_ENV=test