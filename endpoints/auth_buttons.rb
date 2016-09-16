get '/add_to_slack' do
	erb :auth_button, :locals => {query_params: SLACK_APP_AUTH_QUERY_PARAMS, alt_text: "Add to Slack", image_name: "add_to_slack"}
end

get '/sign_in_with_slack' do
	erb :auth_button, :locals => {query_params: SLACK_USER_AUTH_QUERY_PARAMS, alt_text: "Sign in with Slack", image_name: "sign_in_with_slack"}
end