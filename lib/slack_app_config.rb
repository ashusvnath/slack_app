class SlackAppConfig
	class << self
		private def fetch_env!(config_name)
			value = ENV[config_name]
			raise "Config environment variable missing #{config_name}" if value.nil? || value == ""
			value
		end
	end
	%W(SLACK_CLIENT_ID SLACK_CLIENT_SECRET VERIFICATION_TOKEN).each  do |config_name|
		v  = fetch_env!(config_name)
		self.class.send(:define_method, config_name.downcase) do v end
	end
end
