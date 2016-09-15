post '/fortune' do
  index, text = FORTUNES.next
  headers('Content-Type' => "application/json")
  JSON.dump({
              text: text,
              "attachments": [{
                                text: "Did your like this fortune ?",
                                callback_id: "fortune_vote",
                                color: "#3AA3E3",
                                attachment_type: "default",
                                actions: [
                                  {
                                    "name": "vote_#{index}",
                                    "text": ":thumbsup:",
                                    "type": "button",
                                    "value": "up"
                                  },
                                  {
                                    "name": "vote_#{index}",
                                    "text": ":thumbsdown:",
                                    "type": "button",
                                    "value": "down"
                                  }
                                ]
              }]
  })
end
