require './dictionary.rb'
require './checker.rb'
class Hangman
	include Checker 
	attr_accessor :guessed_word, :secret_word, :body_count, :letters_guessed

	def initialize
		dictionary = Dictionary.new
		@secret_word = dictionary.file.readlines.sample
		@guessed_word = secret_word.gsub(/[a-z]/,"*")
		@body_count = 8
		@letters_guessed = []
		play
	end

	def play
		puts "Welcome to Hangman!"
		continue_game
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
			is_dead
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
			is_dead
		else 
			indices.each {|x| self.guessed_word[x] = secret_word[x]} 
			winner
		end
	end

	def is_dead
		if body_count <= 0
			puts "I'm sorry, but your game is over. The word was #{secret_word}."
		else
			puts "You have #{body_count} tries left."
			continue_game
		end
	end

	def continue_game
		puts "Do you wish to guess the secret word (s) or a letter? (l)\nIf you ever wish to discontinue type quit (q)."
		response = gets.chomp.downcase
		case response
		when "secret word","s"
			guess_word
		when "letter","l"
			guess_letter
		when "quit","q"
			puts "It was nice having you."
		else
			puts "There's three simple options to choose from. Choose one."
			continue_game
		end
	end

	def quit
		puts "Are you trying to quit (q) or is this your guess (g)?"
		response = gets.chomp.downcase
		case response
		when "quit","q"
			puts "Thank you for playing. Come back soon."
		when "guess","g"
			if secret_word.count("q") > 0
				puts "GREAT! This is what you have thus far: #{guessed_word}."
				winner
			else
				puts "WRONG! TRY HARDER BRUH!"
				self.body_count -= 1
				is_dead
			end
		else
			quit
		end
	end
	
	def winner
		if guessed_word == secret_word.downcase
			puts "DING DING DING, YOU DAH WINNAH."
		else
			puts "Correct! This is what you have thus far: #{guessed_word}"
			continue_game
		end
	end
end
Hangman.new