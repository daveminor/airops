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

role :app, "daphne.sus4.net"
role :web, "daphne.sus4.net"
role :db,  "daphne.sus4.net", :primary => true

after "deploy:setup", :change_ownership
task :change_ownership, :roles => :app do
  sudo "chown -R airops:airops #{deploy_to}/.."
end

before "deploy:migrate", :move_shared
task :move_shared, :roles => :app do
  run "cp #{shared_path}/database.yml #{current_path}/config/database.yml"
end
