set :deploy_to, "/home/airops/myairportoperations.com"

after "deploy:finalize_update", :set_config_files
task :set_config_files, :roles => :app do
  run "cp #{shared_path}/setup/_google_analytics.html #{release_path}/app/views/shared/"
  run "cp #{shared_path}/setup/mongrel_cluster.yml #{release_path}/config/"
end
