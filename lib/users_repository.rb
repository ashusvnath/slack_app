class UsersRepository
	def initialize
		@users_registry = {}
	end

	def registered?(user, team)
		@users_registry[make_key(user, team)]
	end

	def register(user, team, email)
		@users_registry[make_key(user, team)] = email
	end

	private
	def make_key(user, team)
		"#{user}_#{team}".to_sym
	end
end