def make_user_auth_endpoint
	"https://slack.com/oauth/authorize?scope=identity.basic,identity.email&client_id=#{SlackAppConfig.slack_client_id}&state=user"
end

post '/interactive_messages' do
	logger.info request.params
	data = JSON.parse(request["payload"])
	user = data["user"]["id"]
	team = data["team"]["id"]
	if USERS_REPOSITORY.registered?(user, team)
		"Please Sign in with slack here : #{make_user_auth_endpoint}"
	else
		status 200
		headers("Content-Length" => "0")
		""
	end
end