require_relative 'boot'
require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Intelligence
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
       config.action_mailer.default_url_options = { :host => 'localhost:3000' }
       config.action_mailer.delivery_method = :smtp
       config.action_mailer.perform_deliveries = true
       config.action_mailer.raise_delivery_errors = true
       config.action_mailer.default :charset => "utf-8"

       ActionMailer::Base.smtp_settings = {
         :address => "smtp.gmail.com",
         :port => 587,
         :authentication => :plain,
         :domain => 'gmail.com',
         :user_name => ENV['email'],
         :password => ENV['email_password'],
       }
###

  end
end
