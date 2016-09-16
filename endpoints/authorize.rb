def log_msg(logger, message, success)
  logger.info("#{message} %s" % [  success ? "successfull" : "failed"])
end

get '/authorize' do
  if code = request.params["code"]
    state = request.params["state"]
    if state == USER_STATE
      key, email = SLACK_AUTH_CLIENT.auth_user(code)
      USERS_REPOSITORY.register(key, email)
      if key && email && data = PendingAuth.dequeue(key)
        if data
          logger.info("Replacing ephemeral message")
          HTTParty.post(data[:url], data[:message])
        end
      end
      log_msg(logger, "User Authorization", USERS_REPOSITORY.registered?(key))
    else
      token = SLACK_AUTH_CLIENT.auth(code)
      log_msg(logger, "App Authorization", !token.nil?)
    end
  end
  ""
end
