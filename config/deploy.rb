set :application, "Aflatune"
set :domain, "ec2-184-72-5-4.us-west-1.compute.amazonaws.com"

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true        # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :db do
  task :symlink, :except => { :no_release => true } do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
after "deploy:finalize_update", "db:symlink"

namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundled_gems')
    release_dir = File.join(File.join(current_release, 'vendor'), 'bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end
 
  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} ; bundle install --path vendor/bundle"
  end
end
 
after 'deploy:update_code', 'bundler:bundle_new_release'

default_run_options[:pty] = true
set :repository,  "git@github.com:edufied/Aflatune.git"
set :scm, "git"
set :user, "ubuntu"

set :deploy_to, "/home/ubuntu/www/#{application}.com"

ssh_options[:forward_agent] = true

set :branch, "master"

set :deploy_via, :remote_cache

ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/edufied_ec2.pem"]
