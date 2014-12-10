# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'

 # for this app only!
require 'twitter'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

def client
  Twitter::REST::Client.new do |config|
    config.consumer_key        = "M73y52uYN8piejAwWTMvPhm6B"
    config.consumer_secret     = "5Ne59WsyY4AOdV9qYeHIIqqkd3HFAgXBX6Ac3F8O9Ad31iEhUZ"
    config.access_token        = "81753202-GMEcVm1Gly5ZjSQEec21xen1qjtLOFxS4Ww7n1rXi"
    config.access_token_secret = "ujjLL7gXZHvLkHiK2ZhTFvkaCjBszVGELEHZlTlfRzT96"
  end
end
