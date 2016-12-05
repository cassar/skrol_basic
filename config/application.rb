require_relative 'boot'

require 'rails/all'

# Require all ruby files in ./lib directory.
Dir["./lib/console_methods/*.rb"].each {|file| require file }

require './lib/console_methods/translate_string.rb'
require './lib/console_methods/utilities.rb'
require './lib/console_methods/populate_chars_cfs.rb'
require './lib/console_methods/calculate_wcfbs.rb'
require './lib/console_methods/calculate_wcfts.rb'

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
