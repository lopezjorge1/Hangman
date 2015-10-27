require './checker.rb'
class Player
	include Checker
	attr_accessor :letters_guessed, :guessed_word, :secret_word

	def initialize(secret_word) 
		@letters_guessed = []
		@guessed_word = secret_word.gsub(/[a-z]/,"*")
		@secret_word = secret_word
	end
	
	def guess_word
		puts "What do you think the secret word is?"
		response = gets.chomp.downcase
		case response
		when secret_word
			puts "WINNAH WINNAH CHICKEN DINNAH."
		else
			puts "Errrr! WRONG. Try again."
			self.body_count -= 1
		end
	end

	def guess_letter
		puts "What do you think one of the letters are yung buck?\nThese are the letters you've guessed so far: #{letters_guessed}."
		response = gets.chomp.downcase
		indices = secret_word.chars.each_index.select {|x| secret_word[x] == response}
		letters_guessed.push(response)
		if repetition?(letters_guessed) then guess_letter end
		if response == "q"
			quit
		elsif secret_word.include?(response) == false 
			puts "WRONG! TRY HARDER BRUH."
			self.body_count -= 1
		else 
			indices.each {|x| self.guessed_word[x] = secret_word[x]} 
		end
	end
end
	