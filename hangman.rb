class Hangman
	attr_accessor :secret_word, :guessed_word, :body_count, :letters_guessed, :name
	
	@@body_count = 0
	@@letters_guessed = []
	
	def initialize(secret_word)
		@secret_word = secret_word.downcase
		@guessed_word = guessed_word
	end
	
	def play
		p "Welcome to the original Hangman! What's your name?"
		@@name = gets.chomp.capitalize
		p "Hi #{@@name}! Your opponent is convinced that you'll kill me, so let's prove them wrong."
		p "Would you like to guess the secret word, or do you want to guess a letter (L) of the word (W)?"
		response = gets.chomp.downcase
		
		case response
		when "quit","Q","q"
			p "Game over!"
			p "The secret word was #{secret_word}."
		when "word","W","w"
			guess_word
		when "letter","L","l"
			guess_letter
		else
			p "Would you like to guess the WORD or a LETTER?"
			p "If at any time you wish to discontinue the game, type quit."
			response = gets.chomp.downcase
			
			case response 
			when "word","W","w"
				guess_word
			when "letter","L","l"
				guess_letter
			when "quit","Q","q"
				p "Game over!"
				p "The secret word was #{secret_word}."
			else
				p "Anytime you would like to play, you know where to find me."
			end
		end
	end

	def guess_word
		p "What do you think the secret word is?"
		response = gets.chomp.downcase

		case response
		when secret_word
			p "Congratulations #{@@name}! You didn't kill me."
		when "quit","Q","q"
			p "Game over!"
			p "The secret word was #{secret_word}."
		else
			p "Here's a tip #{@@name}: start with guessing letters. WRONG."
			@@body_count += 1
			dead?
		end
	end

	def guess_letter
		p "What do you think the lucky letter is?"
		p "Keep in mind these are the letter you've guessed thus far: #{@@letters_guessed.map {|x| x.capitalize}.join(" , ")}."
		let = gets.chomp.downcase
		@@letters_guessed.push(let)
		
		if secret_word.count(let) <= 0
			p "Incorrect! Try harder next time."
			@@body_count += 1
			dead?
		else
			guessed_word = secret_word.gsub(/[^#{@@letters_guessed}]/, "*")
			p "Good job! This is what you have thus far, #{guessed_word}."
			
			if guessed_word.downcase == secret_word.downcase
				p "Congratulations #{@@name}! You didn't kill me."
			else
				continue_game
			end	
		end
	end
#If letter guessed already, it shouldn't count on body_count
	def dead?
		if @@body_count >= 8 
			p "You proved your opponent right, #{@@name}. LOSER."
			p "The secret word was #{secret_word}."
		else
			continue_game
		end
	end

	def continue_game
		p "Would you now like to guess the secret word now or a letter?"
		p "Keep in mind you have #{8 - @@body_count} tries left."
		response = gets.chomp.downcase

		case response
		when "quit","Q","q"
			p "Game over!"
			p "The secret word was #{secret_word}."
		when "word","W","w"
			guess_word
		when "letter","L","l"
			guess_letter
		else
			p "Would you like to guess the WORD or a LETTER?"
			p "If at any time you wish to discontinue the game, type quit."
			response = gets.chomp.downcase
			
			case response 
			when "word","W","w"
				guess_word
			when "letter","L","l"
				guess_letter
			when "quit","Q","q"
				p "Game over!"
				p "The secret word was #{secret_word}."
			else
				p "Anytime you would like to play, you know where to find me."
			end
		end
	end
end


game = Hangman.new("limerence")
game.play