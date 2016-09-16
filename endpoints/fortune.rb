post '/fortune' do
  logger.info(request.body.read)
  index, text = FORTUNES.next
  headers('Content-Type' => "application/json")
  JSON.dump({
              text: text,
              response_type: "in_channel",
              "attachments": [{
                                text: "Did your like this fortune ?",
                                callback_id: "fortune_vote",
                                color: "#3AA3E3",
                                attachment_type: "default",
                                actions: [
                                  {
                                    "name": "#{index}",
                                    "text": ":thumbsup:",
                                    "type": "button",
                                    "value": "up"
                                  },
                                  {
                                    "name": "#{index}",
                                    "text": ":thumbsdown:",
                                    "type": "button",
                                    "value": "down"
                                  }
                                ]
              }]
  })
end

get '/stats' do
  message = FORTUNES.stats
  JSON.dump(message)
end
