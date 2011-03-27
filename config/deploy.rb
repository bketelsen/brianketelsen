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

# =============================================================================
# ROLES
# =============================================================================
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# =============================================================================
# OPTIONS
# =============================================================================
default_run_options[:pty] = true
set :ssh_options, {
  :paranoid => false
}



namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart do ; end

  desc "Deploy the app"
  task :default do
    update
  end

  desc "Setup and clone the repo."
  task :setup do
    # setup
    sudo "mkdir -p #{vhost}/repository/"
    # permissions
    sudo "chown -R #{owner}:#{group} #{repo_dir}"
    sudo "chmod -R g+w #{repo_dir}"
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
