# make sure running as root user

echo "Running updates..." 
apt-get -y update
apt-get install linux-headers-2.6.32-5-amd64
apt-get -y upgrade
apt-get -y install curl git-core python-software-properties build-essential git-core curl libssl-dev libreadline5 libreadline5-dev zlib1g zlib1g-dev libcurl4-openssl-dev libxslt-dev libxml2-dev
 
# add-apt-repository
echo "Add apt repository..."
curl -o /usr/sbin/add-apt-repository  http://blog.anantshri.info/content/uploads/2010/09/add-apt-repository.sh.txtchmod o+x /usr/sbin/add-apt-repository
chown root:root /usr/sbin/add-apt-repository
 
# MySQL
echo "Installing MySQL..."
apt-get install mysql-server
apt-get install libmysqlclient-dev
 
# Apache
echo "Installing Apache..."
apt-get install apache2
apt-get install libapache2-mod-passenger
service apache2 start 
 
# Node.jsadd-apt-repository ppa:chris-lea/node.js
echo "Installing nodejs..."
apt-get -y update
apt-get -y install nodejs
 
# Memcached
echo "Installing Memcached..."
apt-get -y install memcached
service memcached start 
 
# Install Firewall
#echo "Installing Firewall..."
#apt-get -y install ufw
#ufw enable
#ufw allow 22
#ufw allow 80

# RVM
echo "Installing RVM..."
\curl -L https://get.rvm.io | bash -s stable --rails # Or, --ruby=1.9.3
source /usr/local/rvm/scripts/rvm

echo "Installing ruby-2.0.0"
rvm install ruby-2.0.0
rvm reload

echo "Installing ruby-1.9.3-p0"
rvm install ruby-1.9.3-p0
rvm reload

echo "Configuring ruby-1.9.3-p0"
#source ~/.bash_profile
rvm reload
/bin/bash --login
rvm use 1.9.3 --default
 
# Add deployer user
# adduser deployer --ingroup sudo
# su deployer 
# shutdown -r now

# Redis
# On Mac OS use brew install redis
echo "Installing Redis..."
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
apt-get install tcl8.5
cd redis-stable
make
mkdir /etc/redis
mkdir /var/redis
cp utils/redis_init_script /etc/init.d/redis_6379
