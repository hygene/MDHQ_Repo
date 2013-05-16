#!/usr/local/bin/ruby -w

# Used to validate 2d array returned by CSV parser after consuming CSV input board
class Sudoku_CSV_Validator
	BOARD_DIMENSION = 9

	def initialize (arr_of_arrs)
		@arr_of_arrs = arr_of_arrs
	end

	# Validate 2d array is 9x9
	def board_dim_valid
		dim_valid = false
		if @arr_of_arrs
			dim_valid = @arr_of_arrs.length == BOARD_DIMENSION
			if dim_valid
				for i in 0..BOARD_DIMENSION-1
					return false if not @arr_of_arrs[i].length == BOARD_DIMENSION
				end
			end
		end
		return dim_valid
	end

	#validate board's values are valid
	def board_values_valid
		return false if !@arr_of_arrs

		@arr_of_arrs.each do |sub|
			sub.each do |val|
				# puts "val: ",val,", length = ",val.length
				if val.length != 1 || !"-123456789".include?(val)
					return false 
				end
			end
		end
		return true
	end
end