class Hangman
	attr_accessor :secret_word, :guessed_word, :new_word, :body_count, :letters_guessed
	
	@@body_count = 0
	@@letters_guessed = []
	
	def initialize(secret_word)
		@secret_word = secret_word.downcase
		@guessed_word = guessed_word
		@new_word = new_word
	end
	
	def play
		p "Welcome to the unoriginal original Hangman!"
		p "I assume you would like to play!"
		p "To get you started, would you like to guess the word or just a letter?"
		response = gets.chomp.downcase
		
		case response
		when "quit"
			p "Game over!"
			p "The winning word was #{secret_word}."
		when "word"
			guess_word
		when "letter"
			guess_letter
		else
			p "Would you like to guess the WORD or a LETTER?"
			p "If at any time you wish to discontinue the game, type quit."
			response = gets.chomp.downcase
			
			case response 
			when "word"
				guess_word
			when "letter"
				guess_letter
			when "quit"
				p "Game over!"
				p "The winning word was #{secret_word}."
			else
				p "Now you're just playing a game that isn't Hangman. BUH-BYE."
			end
		end
	end

	def guess_word
		p "What do you think the secret word is?"
		response = gets.chomp.downcase

		case response
		when secret_word
			p "WINNAH"
		when "quit"
			p "Game over!"
			p "The winning word was #{secret_word}."
		else
			p "Here's a tip: start with guessing letters. WRONG."
			@@body_count += 1
			dead?
		end
	end

	def guess_letter
		p "What do you think the lucky letter is?"
		let = gets.chomp.downcase
		@@letters_guessed.push(let)
		
		case let 
		when "quit"
			p "Game over!"
			p "The winning word was #{secret_word}."
		end

		if secret_word.count(let) <= 0
			p "WRONG!"
			@@body_count += 1
			dead?
		else
			guessed_word = secret_word.gsub(/[^#{@@letters_guessed}]/, "*")
			p "Good job! This is what you have thus far, #{guessed_word}."
			
			if guessed_word.downcase == secret_word.downcase
				p "WINNAH!"	
			else
				continue_game
			end	
		end
	end

	def dead?
		if @@body_count >= 8
			p "You just hung me, thanks. Loser!"
			p "The winning word was #{secret_word}."
		else
			continue_game
		end
	end

	def continue_game
		p "Would you now like to guess the word now or a letter?"
		response = gets.chomp.downcase

		case response
		when "quit"
			p "Game over!"
			p "The winning word was #{secret_word}."
		when "word"
			guess_word
		when "letter"
			guess_letter
		else
			p "Would you like to guess the WORD or a LETTER?"
			p "If at any time you wish to discontinue the game, type quit."
			response = gets.chomp.downcase
			
			case response 
			when "word"
				guess_word
			when "letter"
				guess_letter
			when "quit"
				p "Game over!"
				p "The winning word was #{secret_word}."
			else
				p "Now you're just playing a game that isn't Hangman. BUH-BYE."
			end
		end
	end
end


game = Hangman.new("hidden")
game.play
# one problem for guess_letter could be that once a letter is guessed, for example d
# then it would become **dd**, but since the method I used transforms anything that
# isn't the letter guessed, then the d's would become *'s in the next round