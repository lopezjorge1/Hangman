require './dictionary.rb'
require './hangman_player.rb'
class Hangman
	attr_accessor :secret_word, :player

	def initialize
		dictionary = Dictionary.new
		@secret_word = dictionary.file.readlines.sample
		@player = Player.new(secret_word)
		play
	end

	def play
		puts "Welcome to Hangman!"
		continue_game
	end

	def is_dead
		if player.body_count <= 0
			puts "I'm sorry, but your game is over. The word was #{secret_word}"
			exit
		else
			puts "You have #{player.body_count} tries left"
			continue_game
		end
	end

	def continue_game
		puts "Do you wish to guess the secret word (s) or a letter? (l)\nIf you ever wish to discontinue type quit (q)"
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
			puts "It was nice having you"
		else
			puts "There's three simple options to choose from. Choose one"
			continue_game
		end
	end

	def winner
		if player.guessed_word == secret_word.downcase
			puts "DING DING DING, YOU DAH WINNAH."
		elsif secret_word.include?(player.letters_guessed.last)
			puts "Correct! This is what you have thus far: #{player.guessed_word}"
			continue_game
		end
	end
end
Hangman.new