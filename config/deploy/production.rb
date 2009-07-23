set :deploy_to, "/home/airops/myairportoperations.com"

after "deploy", :set_config_files
task :set_config_files, :roles => :app do
  run "cp #{shared_path}/google_analytics.html #{current_path}/app/views/shared/"
end
