class UsersRepository
	def initialize
		@users_registry = {}
	end

	def registered?(key)
		@users_registry[key]
	end

	def register(key, email)
		@users_registry[key] = email
	end
end