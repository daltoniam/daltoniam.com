set :application, 'daltoniam'
set :repo_url, 'git@github.com:daltoniam/daltoniam.com.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/var/www/daltoniam'
set :scm, :git
set :format, :pretty
set :stages, %w(development staging production)
set :default_stage, "development"
set :branch, 'master'
set :puma_bind, 'unix:///var/run/daltoniam.sock'
# set :log_level, :debug
 set :pty, true

# set :linked_files, %w{config/database.yml}
 set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "sudo service god restart"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end