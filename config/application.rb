require_relative 'boot'

require 'rails/all'

# Require all ruby files in ./lib directory.
Dir["./lib/static_content_scores/*.rb"].each {|file| require file }
Dir["./lib/users/*.rb"].each {|file| require file }
Dir["./lib/program/*.rb"].each {|file| require file }
Dir["./lib/content/*.rb"].each {|file| require file }
Dir["./lib/onboard/*.rb"].each {|file| require file }
Dir["./lib/offboard/*.rb"].each {|file| require file }
Dir["./lib/catalogues/*.rb"].each {|file| require file }
Dir["./lib/*.rb"].each {|file| require file }

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SkrolBasic
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
  end
end
