class SlackAuthClient
  GENERAL_AUTH_ENDPOINT = response = "https://slack.com/api/oauth.access"
  USER_AUTH_ENDPOINT = response = "https://slack.com/api/users.identity"
  def initialize
    @partial_credentails = {
      client_id: SlackAppConfig.slack_client_id,
      client_secret: SlackAppConfig.slack_client_secret
    }
  end

  def auth(code)
    response = HTTParty.post(GENERAL_AUTH_ENDPOINT, body: @partial_credentails.merge({code: code}))
    JSON.parse(response.body)['access_token']
  end

  def auth_user(code)
    token = auth(code)
    response = HTTParty.post(USER_AUTH_ENDPOINT, body: {token: token})
    user_data = JSON.parse(response.body) rescue nil
    if user_data
      [user_data["user"]["id"], user_data["team"]["id"], user_data["user"]["email"]]
    end
  end
end
