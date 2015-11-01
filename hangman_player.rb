require './checker.rb'
class Player
	include Checker
	attr_accessor :letters_guessed, :guessed_word, :secret_word, :body_count

	def initialize(secret_word) 
		@letters_guessed = []
		@guessed_word = secret_word.gsub(/[a-z]/,"*")
		@secret_word = secret_word
		@body_count = 5
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
		puts "What do you think one of the letters are yung buck?\nThese are the letters you've guessed so far: #{letters_guessed}"
		response = gets.chomp.downcase
		indices = secret_word.chars.each_index.select {|x| secret_word[x] == response}
		letters_guessed.push(response)
		if repetition?(letters_guessed) then guess_letter end
		if response == "q"
			quit
		elsif secret_word.include?(response) == false 
			self.body_count -= 1
			if body_count != 0 then puts "WRONG! TRY HARDER BRUH." end
		else 
			indices.each {|x| self.guessed_word[x] = secret_word[x]} 
		end
	end

	def quit
		puts "Are you trying to quit (q) or is this your guess (g)?"
		response = gets.chomp.downcase
		case response
		when "quit","q"
			puts "Thank you for playing. Come back soon."
			exit
		when "guess","g"
			if secret_word.count("q") > 0
				puts "GREAT! This is what you have thus far: #{guessed_word}"
			else
				puts "WRONG! TRY HARDER BRUH!"
				self.body_count -= 1
			end
		else
			quit
		end
	end
end
	