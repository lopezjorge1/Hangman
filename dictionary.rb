class Dictionary
	attr_reader :file
	def initialize
		@file = File.new("wordsEn.txt","r")
	end
end