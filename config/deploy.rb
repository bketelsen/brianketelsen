  
set :application, "brianketelsen"
set :domain, "www.brianketelsen.com"
# set :gems_for_project, %w(dr_nic_magic_models swiftiply) # list of gems to be installed
set :scm_user, "bketelsen_bketelsen"
set :scm_password, "ncc1701c"
set :svn_user, "bketelsen_bketelsen"
set :svn_password, "ncc1701c"
set :user,  "root"
set :runner, "www-data"
set :repository, Proc.new { "--username #{scm_user} --password #{scm_password} --no-auth-cache http://bketelsen.unfuddle.com/svn/bketelsen_bkhomepage/trunk/" }

set :use_sudo,	:true	
# If you aren't deploying to /var/www/apps/#{application} on the target
# servers (which is the deprec default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :subversion

role :app, "drexel.brianketelsen.com"
role :web, "drexel.brianketelsen.com"
role :db,  "drexel.brianketelsen.com", :primary => true

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
