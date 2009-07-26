set :stages, %w(development production)
set :default_stage, 'development'
require 'capistrano/ext/multistage'

set :application, "airops"
set :repository,  "git@github.com:daveminor/airops.git"

set :scm, :git
ssh_options[:forward_agent] = true
set :branch, "master"
set :git_enable_submodules, 1
set :deploy_via, :remote_cache
set(:mongrel_conf) { "#{deploy_to}/current/config/mongrel_cluster.yml" }

role :app, "daphne.sus4.net"
role :web, "daphne.sus4.net"
role :db,  "daphne.sus4.net", :primary => true

after "deploy:setup", :change_ownership
task :change_ownership, :roles => :app do
  sudo "chown -R airops:airops #{deploy_to}/.."
end

before "deploy:finalize_update", :move_shared
task :move_shared, :roles => :app do
  run "cp #{shared_path}/setup/database.yml #{release_path}/config/database.yml"
end

after "deploy:finalize_update", :set_owner
task :set_owner, :roles => :app do
  sudo "chown -R airops:airops #{release_path}"
  sudo "ln -s #{shared_path}/photos #{release_path}/public/"
end

namespace :deploy do
  namespace :mongrel do
    [ :stop, :start, :restart ].each do |t|
      desc "#{t.to_s.capitalize} the mongrel appserver"
      task t, :roles => :app do
        #invoke_command checks the use_sudo variable to determine how to run the mongrel_rails command
        invoke_command "mongrel_rails cluster::#{t.to_s} -C #{mongrel_conf}", :via => run_method 
      end
    end
  end

  desc "Custom restart task for mongrel cluster"
  task :restart, :roles => :app, :except => { :no_release => true } do
    deploy.mongrel.restart
  end

  desc "Custom start task for mongrel cluster"
  task :start, :roles => :app do
    deploy.mongrel.start
  end

  desc "Custom stop task for mongrel cluster"
  task :stop, :roles => :app do
    deploy.mongrel.stop
  end

end

