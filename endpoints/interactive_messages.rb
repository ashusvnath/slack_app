post '/interactive_messages' do
	logger.info request.params
	data = JSON.parse(request["payload"])
	user = data["user"]["id"]
	team = data["team"]["id"]
	if UsersRepository.registered?(user,team)
		"Please Sign in with slack here : https://slack.com/oauth/authorize?scope=identity.basic,identity.email&client_id=#{SlackAppConfig.slack_client_id}"
	else
		status 200
		headers("Content-Length" => "0")
		""
	end
end