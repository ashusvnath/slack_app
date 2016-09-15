require 'sinatra'
require 'sinatra/reloader' if settings.development?
require 'json'
require 'httparty'

enable :logging
set :public_folder, './public'

def setup_load_files(*paths)
  puts "Picking up new files"
  paths.each do |path|
	  Dir.glob("#{path}/*").each do |file|
	    load(file)
	    also_reload(file) if settings.development?
	  end
  end
  puts "...done"
end

if settings.development?
	Signal.trap("HUP") {
	  setup_load_files("lib", "endpoints")
	}
end

setup_load_files("lib", "endpoints")
FORTUNES = Fortunes.new("data/fortunes.txt")
USERS_REPOSITORY = UsersRepository.new
USER_STATE = "user"
