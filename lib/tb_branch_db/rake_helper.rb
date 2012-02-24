module TbBranchDb
  module RakeHelper

    def load_database_config
      config = File.read("config/database.yml")
      config = ERB.new(config).result
      YAML.load(config)
    end

    def current_branch
      `git symbolic-ref HEAD 2>/dev/null`.chomp.sub('refs/heads/', '')
    end

    def master_database
      branch = current_branch
      database = load_database_config[Rails.env]['database']
      database.sub!("_#{branch}", '')
      database
    end

    def run(cmd)
      sh cmd
    end

  end
end