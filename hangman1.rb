#when I press q and then g it doesn't work correctly
require './dictionary.rb'
require './hangman_player.rb'
class Hangman
	attr_accessor :secret_word, :body_count, :player

	def initialize
		dictionary = Dictionary.new
		@secret_word = dictionary.file.readlines.sample
		@body_count = 8
		@player = Player.new(secret_word)
		play
	end

	def play
		puts "Welcome to Hangman!"
		continue_game
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
			player.guess_word
			is_dead
		when "letter","l"
			player.guess_letter
			winner
			is_dead
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