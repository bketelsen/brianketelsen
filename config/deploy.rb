set :application, "brianketelsen"


set :user,  "briank"
set :runner, "www-data"


# If you aren't deploying to /var/www/apps/#{application} on the target
# servers (which is the deprec default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :subversion



# If you aren't deploying to /var/www/apps/#{application} on the target
# servers (which is the deprec default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"
ssh_options[:keys] = ["/Users/briank/.ssh/id_rsa"]



role :gateway_as_root, "drexel.brianketelsen.com"
role :gateway, "drexel.brianketelsen.com"
role :app, "drexel.brianketelsen.com"
role :web, "drexel.brianketelsen.com"
role :db,  "drexel.brianketelsen.com", :primary => true

set :use_sudo,	true	

namespace :deploy do 
  task :start, :roles => :app do 
  end 

  task :stop, :roles => :app do 
  end
 
  task :restart, :roles => :app do 
    run "touch #{release_path}/tmp/restart.txt" 
  end

  task :after_update_code, :roles => :app do 
    run "rm -rf #{release_path}/public/.htaccess"
  end 
end 
