require 'yaml'
require 'rails'
require 'fileutils'
require "tb_branch_db/rake_helper"

include TbBranchDb::RakeHelper

namespace :db do

  namespace :branch do

    desc "setup database.yml for branching"
    task :setup do
      HEAD=%q{
<%
  # http://mislav.uniqpath.com/rails/branching-the-database-along-with-your-code/
  branch = `git symbolic-ref HEAD 2>/dev/null`.chomp.sub('refs/heads/', '')
  suffix = `git config --bool branch.#{branch}.database`.chomp == 'true' ? "_#{branch}" : ""
%>
}
      FileUtils.cp "#{Rails.root}/config/database.yml", "#{Rails.root}/config/database.yml.orig"
      puts "backup database.yml to database.yml.orig"

      config = load_database_config
      dbname = config[Rails.env]['database']
      config[Rails.env]['database'] = "#{dbname}<%= suffix %>"

      content = YAML.dump(config)
      content.sub!('---', HEAD)

      File.open("#{Rails.root}/config/database.yml", "w") do |file|
        file.write(content)
      end

      puts "update database.yml for branching"
      puts "please run 'rake db:branch' to branch db"
    end

    desc "cleanup db branch (drop database)"
    task :cleanup do
      puts self

      branch = current_branch
      database = master_database

      run "git config --bool branch.#{branch}.database false"
      run "mysql -u root -e 'drop database #{database}_#{branch}'"
    end

  end

  desc "branch db"
  task :branch do
    branch = current_branch
    database = master_database

    run "git config --bool branch.#{branch}.database true"
    run "rake db:create"
    run "mysqldump -u root #{database} | mysql -u root #{database}_#{branch}"
  end


end
