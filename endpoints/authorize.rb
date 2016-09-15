def log_msg(logger, message, success)
  logger.info("#{message} %s" % [  success ? "successfull" : "failed"])
end

get '/authorize' do
  if code = request.params["code"]
    state = request.params["state"]
    if state == USER_STATE
      user, team, email = SlackAuthClient.new.auth_user(code)
      USERS_REPOSITORY.register(user, team, email)
      log_msg(logger, "User Authorization ", USERS_REPOSITORY.registered?(user, team))
    else
      token = SlackAuthClient.new.auth(code)
      log_msg(logger, "App Authorization ", !token.nil?)
    end
  end
  [200, [""]]
end

