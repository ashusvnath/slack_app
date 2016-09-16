require 'sinatra'
require 'sinatra/reloader' if settings.development?
require 'json'
require 'httparty'
require 'uri'

enable :logging
set :public_folder, './public'
set :views, './templates'

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
PENDING_AUTH = PendingAuth.new
SLACK_AUTH_CLIENT = SlackAuthClient.new
SIGN_IN_WITH_SLACK = 'sign_in_with_slack'
USER_STATE = "user"
SLACK_APP_AUTH_QUERY_PARAMS=URI.encode_www_form({scope: 'incoming-webhook,commands', client_id: SlackAppConfig.slack_client_id})
SLACK_USER_AUTH_QUERY_PARAMS=URI.encode_www_form({scope: 'identity.basic,identity.email', client_id: SlackAppConfig.slack_client_id, :state => USER_STATE})