# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
set :application, "brianketelsen"
set :domain, "www.brianketelsen.com"

set :deploy_to, "/home/briank/brianketelsen"
set :user, "briank"
set :owner, "briank"
set :group, "briank"
set :branch, "master"

set :use_sudo, false

set :scm, :git

set :repository,  "git@github.com:bketelsen/brianketelsen.git"
set :executable, "bkweb"


# =============================================================================
# ROLES
# =============================================================================
role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :default_environment, { 
  'PATH' => "/home/briank/go/bin:/opt/ruby-enterprise-1.8.6-20090610/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$PATH",
  'GOARCH'=>"amd64",
  'GOROOT'=>"/home/briank/go",
  'GOOS'=>"linux"

}

namespace :deploy do
  task :start do 
    stop
    run "make"
    run "/usr/sbin/monit start #{executable}"
  end
  task :stop do 
    run "/usr/sbin/monit stop #{executable}"
  end
  task :restart do 
    stop
    start
  end

  desc "Deploy the app"
  task :default do
    update
    restart
  end

  desc "Setup and clone the repo."
  task :setup do
     # clone
    run "git clone #{repository} #{deploy_to}"
  end

  desc "compile and link the application"
  task :compile do
    clean
    run "cd #{deploy_to} && make"
  end

  desc "clean the build directory"
  task :clean do
    run "cd #{deploy_to} && make clean"
  end

  desc "Update the deployed code"
  task :update do
    run "cd #{deploy_to} && git pull origin #{branch}"
  end


end
