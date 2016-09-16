get '/add_to_slack' do
	erb :add_to_slack, :locals => {query_params: SLACK_APP_AUTH_QUERY_PARAMS}
end

get '/sign_into_slack' do
	erb :add_to_slack, :locals => {query_params: SLACK_USER_AUTH_QUERY_PARAMS}
end