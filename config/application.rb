require_relative 'boot'

require 'rails/all'

# Require all ruby files in ./lib directory.
Dir["./lib/console_methods_single/*.rb"].each {|file| require file }
Dir["./lib/console_methods_script/*.rb"].each {|file| require file }
Dir["./lib/user_management/*.rb"].each {|file| require file }
Dir["./lib/content_management/*.rb"].each {|file| require file }
Dir["./lib/*.rb"].each {|file| require file }

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SkrolBasic
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
