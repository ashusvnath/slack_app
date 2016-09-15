class Fortunes
	def initialize(path)
		@fortunes = File.read(path).split("\n%\n")
		@votes = {}
	end

	def next
		index = rand(@fortunes.length)
		return [index, @fortunes[index]]
	end

	def upvote(index)
		@votes[index] ||= 0
		@votes[index] += 1
	end

	def downvote(index)
		@votes[index] ||= 0
		@votes[index] += 1
	end
end