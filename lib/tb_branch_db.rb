require "tb_branch_db/version"
require "tb_branch_db/rake_helper"
require "rails"

module TbBranchDb
  class BranchDBTask < Rails::Railtie
    railtie_name :tb_branch_db

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f }
    end
  end
end

