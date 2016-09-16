class PendingAuth
	def initialize
		@pending_auth = {}
	end

	def enqueue(key, url, message)
		@pending_auth[key] = {url: url, message: message})
	end

	def dequeue(key)
		@pending_auth.delete(key)
	end
end