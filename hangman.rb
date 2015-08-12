class Hangman
	attr_accessor :secret_word, :guessed_word, :new_word, :body_count 

	@@body_count = 0
	
	def initialize(secret_word)
		@secret_word = secret_word.downcase
		@guessed_word = secret_word.downcase
		@new_word = new_word
		@@body_count = body_count
	end
	
	def play
		p "Welcome to the unoriginal original Hangman!"
		p "I assume you would like to play!"
		p "To get you started, would you like to guess the word or just a letter?"
		response = gets.chomp.downcase
		
		case response
		when "quit"
			p "I guess you didn't want to play today."
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
				p "This game isn't for the weak. Good choice."
			else
				p "Now you're just playing a game that isn't Hangman. BUH-BYE."
			end
		end
	end

	def guess_word
		p "What do you think the secret word is?"
		response = gets.chomp.downcase
		
		if response == secret_word
			p "Success! You're a winner!"
		elsif response == "quit" 
			p "Already?! I guess you're not built for the game."
		else
			p "Here's a tip: start with guessing letters. WRONG."
			body_count += 1
			continue_game
		end
	end

	def guess_letter
		p "What do you think the lucky letter is?"
		let = gets.chomp.downcase
		
		case let 
		when "quit"
			"Hope you enjoyed losing"
		end

		if secret_word.count(let) <= 0
			p "WRONG!"
			body_count += 1
			dead?
		else 
			new_word = guessed_word.split(//).map {|x| x != let ? x = "*" : x = let}.join
			"Good job! This is what you have thus far, #{new_word}."
			continue_game
		end
	end

	def dead?
		if body_count >= 8
			p "You just hung me, thanks. Loser!"
		else
			continue_game
		end
	end

	def continue_game
		"Hello"
	end


end

#body_count
#continue_game

game = Hangman.new("hidden")
game.play




	
#necessary methods:
#start game
#continue game
#guess word
#guess letter
#dead? (draw_body)
#winner?
#it should keep iterating to ask for what the person wants to input and then checking if they're correct
#so when it checks if the game is over, if the game isn't over it should continue with the guesses
	
