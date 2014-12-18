# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'sidekiq'
require 'redis'

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
require 'oauth'
require 'json'
require 'byebug'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')


TWITTER  = File.expand_path(File.dirname(__FILE__) + "/credentials.yml")
oauth = YAML.load_file(TWITTER)
CONSUMER_KEY = oauth["twitter_consumer_key"]
CONSUMER_SECRET = oauth["twitter_consumer_secret"]




client = Twitter::REST::Client.new do |c|
    c.consumer_key        = CONSUMER_KEY
    c.consumer_secret     = CONSUMER_SECRET
    c.access_token        = "81753202-ftg7E9uyjrpDaJmEXvQSPHX3Pho8gOKJa0oE6Riuh"
    c.access_token_secret = "QG0rW14JezJVsrx2gt0vuzJCkuHLNt4kS4HETfuvmnslu"
end

