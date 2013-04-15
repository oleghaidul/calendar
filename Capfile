require 'capistrano-deploy'
require 'yaml'
require 'erb'

use_recipes :git, :rails, :bundle, :unicorn, :rails_assets, :rvm

server '66.228.44.86', :web, :app, :db, :primary => true
set :user, 'calendar'
set :repository, 'git@github.com:oleghaidul/calendar.git'

set(:deploy_to) { "/home/calendar/production" }

after 'deploy:update', 'bundle:install', 'deploy:assets:precompile'
after 'deploy:restart', 'unicorn:stop', 'deploy:update_crontab'

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd /home/calendar/production && whenever --update-crontab calendar"
  end
end