require 'sinatra'
require 'sinatra/reloader' if settings.development?
require 'json'
require 'httparty'
require './lib/slack_app_config'
require './lib/fortunes'

enable :logging
set :public_folder, './public'

FORTUNES = Fortunes.new("data/fortunes.txt")
def setup_load_files
  puts "Picking up new files"
  Dir.glob("endpoints/*").each do |file|
    load(file)
    also_reload(file) if settings.development?
  end
  puts "...done"
end

if settings.development?
	Signal.trap("HUP") {
	  setup_load_files
	}
end

setup_load_files
