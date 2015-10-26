module Checker
	def repetition?(array)
		letters_used = array.each_with_object(Hash.new(0)) {|letter,counts| counts[letter] += 1}
		letters_used.values.last > 1
	end
end
