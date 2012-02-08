require 'spree_core'

module SynergyInventoryManagement
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w( admin/synergy_imi.css )
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
