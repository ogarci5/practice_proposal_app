###JENKINS INSTALL AND CONFIGURE

#####install jenkins:
	$ wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
	$ sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
	$ sudo apt-get update
	$ sudo apt-get install jenkins

#####Jenkins should start itself as soon as it is installed. If not, start jenkins:
	$	sudo /etc/init.d/jenkins start

-  You can access it by opening a browser and navigating to Jenkins localhost:8080 or wherever Jenkins is being served from.
	
#####Create rsa key so that jenkins can access to github:
	$ sudo su jenkins
	$ ssh-keygen -t rsa

NOTE: when creating a key DO NOT give it a passphrase or it will not be able to connect to github

#####To create a new job:
	- Jenkins runs from port 8080 by default. Open Jenkins by opening a browser and navigating to Jenkins localhost:8080 or wherever Jenkins is being served from.
	- To create a new job: New Job -> Free-style project. If you use Git be sure to install some plugins: Manage Jenkins -> Manage Plugins and install Git plugin, Github plugin to enable fetching data and configuring Github url hook for Jenkins. 

##### Jenkins cannot understand Rspec output. You must install ci_reporter. Do this:

Add to Gemfile:

	group :test do
		gem 'ci_reporter'
	end

Add to Rakefile:

	require 'ci/reporter/rake/rspec'

FOR MORE INFO: http://caldersphere.rubyforge.org/ci_reporter/

##### To create the build:

Go to Configure > Build > Execute Shell > Command, and paste the following:

	#!/bin/bash -x
	
	# load rvm (see ** below)
	source ~/.bashrc                           
	
	# copy database.yml from local app (repo may have different user)
	cp ~/repos/practice_proposal_app_REPO/practice_proposal_app/config/database.yml config/database.yml
	
	# install all gems
	bundle install
	
	# create test db's and prepare ci output
	rake db:test:prepare RAILS_ENV=test
	rake ci:setup:rspec spec RAILS_ENV=test

** Loading rvm: because of the way .bash_profile and .bashrc load environment variables (bash_profile loads at startup, .bashrc when a new session is create in another terminal window.), you must make sure that .bash_profile loads .bashrc at startup and that .bashrc loads RVM. Put this in .bash_profile:

	[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load$
	
	# this will force .bashrc to load in either case -cd
	if [ -f ~/.bashrc ]; then
		source ~/.bashrc
		fi

And put this in .bashrc:

	# Set Jenkins' home
	export JENKINS_HOME=/var/lib/jenkins/.jenkins

	PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting 

NOTE: the build may fail with the error "Could not apply tag...". This happens because
Jenkins tries to create a Git tag (which requires a commit) and the Git username and email
have not been recorded in Jenkins. There are two ways to fix this:

1. Add the Git name and email to project. I didn't do this, so I haven't worked out how.

2. Eliminate tagging: go to Project > Configure > Source Code Management; click the "Advanced" button under the "Branches to build section. Find the "Skip internal tag" checkbox and make sure it's checked. 
	 SEE: http://stackoverflow.com/questions/11122913/jenkinsgit-tell-me-who-you-are-error-why-does-it-need-to-tag

#### More Info

	 http://yakiloo.com/setup-jenkins-and-rvm/
 