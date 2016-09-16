post '/interactive_messages' do
	data = JSON.parse(request["payload"])
	key = AuthKey.make(data["user"]["id"], data["team"]["id"])
	email = USERS_REPOSITORY.registered?(key)
	if email.nil?
		logger.info("User not authorized. Enqueuing response.")
		PENDING_AUTH.enqueue(key, data["response_url"], data["original_message"])
		headers({"Content-Type" => "application/json"})
		JSON.dump({
			message: "Please :slack: *Sign in with slack* here : https://#{request.host}/sign_into_slack",
			response_type: 'ephemeral'
		})
	else
		logger.info("Found #{email} for #{key}")
		""
	end
end