class Hangman
	attr_accessor :secret_word, :guessed_word, :body_count, :letters_guessed, :name
	#Class variables made instead of instance variables so that they could modify throughout the class till the game ends
	
	def initialize(secret_word)
		@secret_word = secret_word.downcase
		@guessed_word = guessed_word
		@body_count = 0
		@letters_guessed = []
	end
	
	def play
		p "Welcome to the original Hangman! What's your name?"
		@@name = gets.chomp.capitalize
		p "Hi #{@@name}! Your opponent is convinced that you'll kill me, so let's prove them wrong."
		p "Would you like to guess the secret word, or do you want to guess a letter (L) of the word (W)?"
		response = gets.chomp.downcase
		
		case response
		when "quit","q"
			p "Game over!"
			p "The secret word was #{secret_word}."
		when "word","w"
			guess_word
		when "letter","l"
			guess_letter
		else
			p "Would you like to guess the WORD or a LETTER?"
			p "If at any time you wish to discontinue the game, type quit (Q)."
			response = gets.chomp.downcase
			
			case response 
			when "word","w"
				guess_word
			when "letter","l"
				guess_letter
			when "quit","q"
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
		when "quit","q"
			p "Game over!"
			p "The secret word was #{secret_word}."
		# When the word is guessed incorrectly, then body_count is incremented
		else
			p "Here's a tip #{@@name}: start with guessing letters. WRONG."
			self.body_count += 1
			dead?
		end
	end
	#I still have to figure out how to quit within guess_letter 
	#What if one of the letters are Q? Or if the word is quit?
	def guess_letter
		p "What do you think the lucky letter is?"
		p "Keep in mind these are the letter you've guessed thus far: #{self.letters_guessed.map {|x| x.capitalize}.join(" , ")}."
		let = gets.chomp.downcase
		self.letters_guessed.push(let)

		#If secret_word doesn't have the letter guessed, then body_count is incremented
		#If the same letter is guessed more than once, then body_count won't be affected
		if secret_word.count(let) <= 0
			p "Incorrect! Try harder next time."
			if self.letters_guessed.count(let) > 1
				p "You also guessed #{let.capitalize} already, so try another letter!"
			else
				self.body_count += 1
			end
			dead?
		#This puts an asterisk on every letter except the letters that are in the array letters_guessed	
		else
			guessed_word = secret_word.gsub(/[^#{self.letters_guessed}]/, "*")
			p "Good job! This is what you have thus far, #{guessed_word}."
			
			if guessed_word.downcase == secret_word.downcase
				p "Congratulations #{@@name}! You didn't kill me."
			else
				continue_game
			end	
		end
	end
#Once body_count reaches a number, then the game is discontinued
	def dead?
		if self.body_count >= 8 
			p "You proved your opponent right, #{@@name}. LOSER."
			p "The secret word was #{secret_word}."
		else
			continue_game
		end
	end

	def continue_game
		p "Would you now like to guess the secret word now or a letter?"
		p "Keep in mind you have #{8 - self.body_count} tries left."
		response = gets.chomp.downcase

		case response
		when "quit","q"
			p "Game over!"
			p "The secret word was #{secret_word}."
		when "word","w"
			guess_word
		when "letter","l"
			guess_letter
		else
			p "Would you like to guess the WORD or a LETTER?"
			p "If at any time you wish to discontinue the game, type quit (Q)."
			response = gets.chomp.downcase
		end
	end
end


game = Hangman.new("quit")
game.play
=begin
If the person guesses the letter q, then it should ask if they would like to quit
or if they would like to input it as a guessed letter, and then if the letter is wrong
body_count would be incremented or it would be included in the letters_guessed array
=end