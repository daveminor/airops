set :deploy_to, "/home/airops/devel.myairportoperations.com"
set :rails_env, 'development'

after "deploy:finalize_update", :set_config_files
task :set_config_files, :roles => :app do
  run "cp #{shared_path}/setup/development.rb #{release_path}/config/environments/"
  run "cp #{shared_path}/setup/mongrel_cluster.yml #{release_path}/config/"
end

