require_relative "boot"

require 'rails'
require 'active_record/railtie'	
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'action_text/engine'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Lacom2022
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    
    config.assets.configure do |env|
	  env.export_concurrent = false
	end
	
	config.active_storage.draw_routes = false
	config.hosts << "lincolnanders.com"
	config.hosts << /[a-z0-9-]+\.lincolnanders\.com/
  end
end
