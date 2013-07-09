set :application, "practice_proposal_app"


# Git and Github setup:
default_run_options[:pty] = true  # Must be set for the password prompt
                                  # from git to work
set :repository, "https://github.com/ogarci5/practice_proposal_app"  # Your clone URL
set :scm, "git"
# set :scm_passphrase, "p@ssw0rd"  # The deploy user's password
set :ssh_options, { :forward_agent => true }  # use local ssh keys tp access the repo
set :branch, "master"             # set the branch that will be deployed (NOTE: deploying from master is a horrible idea)
set :deploy_via, :remote_cache    #   

set :user, "jenkins"           # The server's user for deploys

# Server setup:
# NOTE: if you have only one server, you can replace the following lines 
# with the following:  server "your.server", :app, :web, :db, :primary => true
role :web, "166.78.61.194"                          # Your HTTP server, Apache/etc
role :app, "166.78.61.194"                          # This may be the same as your `Web` server
role :db,  "166.78.61.194", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
