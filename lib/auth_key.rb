class AuthKey
	class << self
		def make(user, team)
			"#{user}_#{team}".to_sym
		end
	end
end