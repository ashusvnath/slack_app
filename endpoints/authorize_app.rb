get '/authorize_app' do
  if request.params["code"]
    response = HTTParty.post("https://slack.com/api/oauth.access", body: {
                               client_id: SlackAppConfig.slack_client_id,
                               client_secret: SlackAppConfig.slack_client_secret,
                               code: request["code"]
    })
    oauth_token = JSON.parse(response.body)['token']
    logger.info("Oauth Authorization %s" % [oauth_token.nil? ? "failed" : "successfull"])
  end
  [200, [""]]
end
