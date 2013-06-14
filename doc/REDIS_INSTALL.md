## Installing Redis 

See here: http://redis.io/topics/quickstart


#### Install Redis in OS X

Do this:

	$ brew install redis

Then laugh at the poor saps who have to install and configure it on Ubuntu.


#### Install Redis In Ubuntu

The best way to install Redis is from source. Just follow these steps:

	wget http://download.redis.io/redis-stable.tar.gz
	tar xvzf redis-stable.tar.gz
	cd redis-stable
	make

At this point you can see if your build works correctly typing `make test`, but this is an optional step. Just do it though, lazypants. It may tell you that it needs tcl.5 or better to run the test. You can install that with the following command: 

	sudo apt-get install tk8.5

You need to copy the Redis server and its command line interface into `/usr/local/bin/` in order to call them from the command line. Navigate to the `/redis-stable/src$` folder. Copy both the Redis server than the command line interface in proper places using the following commands:

    sudo cp redis-server /usr/local/bin/
    sudo cp redis-cli /usr/local/bin/

Check if Redis is working. You should get the response `PONG`:

	$ redis-cli ping
	PONG


#### Configure Redis in Ububtu

A proper install using an init script is strongly suggested. The following instructions can be used to perform a proper installation using the init script shipped with Redis 2.4 in a Debian or Ubuntu based distribution.

We assume you already copied redis-server and redis-cli executables under /usr/local/bin.

- Create a directory where to store your Redis config files and your data:
	
		sudo mkdir /etc/redis
		sudo mkdir /var/redis
		sudo cp utils/redis_init_script /etc/init.d/redis_6379

- Edit the init script.

		sudo nano /etc/init.d/redis_6379

Make sure to modify REDIS_PORT accordingly to the port you are using. Both the pid file path and the configuration file name depend on the port number.

- Copy the template configuration file you'll find in the root directory of the Redis distribution into /etc/redis/ using the port number as name, for instance:

		sudo cp redis.conf /etc/redis/6379.conf

- Create a directory inside /var/redis that will work as data and working directory for this Redis instance:

		sudo mkdir /var/redis/6379

- Edit the configuration file, making sure to perform the following changes:
	Set daemonize to yes (by default it is set to no).
	Set the pidfile to /var/run/redis_6379.pid (modify the port if needed).
	Change the port accordingly. In our example it is not needed as the default port is already 6379.
	Set your preferred loglevel.
	Set the logfile to /var/log/redis_6379.log
	Set the dir to /var/redis/6379 (very important step!)

- Finally add the new Redis init script to all the default runlevels using the following command:

		sudo update-rc.d redis_6379 defaults

You are done! Now you can try running your instance with:

	/etc/init.d/redis_6379 start


#### Install Redis in Your App

If you are using Resque, you don't need to do this -- Resque will handle the interaction. But if you want to use Redis by itself in your app, run the command

	gem install redis




