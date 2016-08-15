require 'bundler'
Bundler.require
require './app_requires.rb'

Log = Logger.new('./logs/application.log', 'daily')
Log.level = Logger::DEBUG

# Routes
api_version = "v1"
map('/') { run ApplicationController }
map('/'+api_version+'/playlists') { run PlaylistsController }
