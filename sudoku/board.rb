#!/usr/local/bin/ruby -w

#Generic board class
class Board

	# constructor - takes in 2d array representing sudoku board.  assuming all rows are equal length
	# params:
	# 	arr_board - 2d array representing sudoku board
	def initialize(arr_board)
		@arr_board = arr_board
		@board_height = arr_board.length
		@board_width = arr_board[0].length
	end

	#get value on board
	#Params :
	# 	i = height of board
	# 	j = length of board
	def get_square(i,j)
		return i.between?(0, @board_height-1) && j.between?(0, @board_width-1) ? @arr_board[i][j] : nil
	end

	#Set value on board
	#Params :
	# 	i = height of board
	# 	j = length of board
	def set_square(i,j,val)
		if i.between?(0, @board_height-1) && j.between?(0, @board_width-1)
			@arr_board[i][j] = val
			return true
		else
			return false
		end
	end

	# get row of board.  returned as array of values
	# Params :
	# 	r = row number to retrieve
	def get_row(r)
		if r.between?(0,@board_height-1)
			return @arr_board[r].dup
		else
			return nil
		end
	end	

	# Get column of board.  returned as array of values
	# Assumption is that all rows are of equal length
	# Params :
	# 	c = column number to retrieve
	def get_col(c)
		if c.between?(0,@board_width-1)
			arr = Array.new(@board_height)
			for i in 0..@board_width-1
				arr[i] = @arr_board[i][c]
			end
			return arr
		else
			return nil
		end
	end



	# print board to stdout
	def print_board
		for i in 0..@board_height-1
			puts @arr_board[i].join(",")
		end
	end

end



class Sudoku_Board < Board
	SUDOKU_BOARD_DIMENSION = 9

	# Constructor
	def initialize(arr_board)
		super(arr_board)
	end

	# Get region of board.  Returned as array of values
	# Region 0 is top-left 3x3 region, Region 1 is top-mid, Region 2 is top-right...Region 7 is bottom-mid, Region 8 is bottom-right
	# Params :
	# 	reg_num = region to retrieve.
	def get_region(reg_num)
		arr = Array.new(SUDOKU_BOARD_DIMENSION)
		# modifiers used to access correct region
		h_mod = 3 * (reg_num / 3)
		w_mod = 3 * (reg_num % 3)
		for h in 0..2
			for w in 0..2
				arr[h*3 + w] = get_square(h + h_mod, w + w_mod)
			end
		end

		return arr
	end

	# Static method to find the region for a given pair of coordinates
	# Params :
	# 	i = height of board
	# 	j = length of board
	def self.coord_to_region (i,j)	
		region = -1
		if i.between?(0,SUDOKU_BOARD_DIMENSION-1) && j.between?(0,SUDOKU_BOARD_DIMENSION-1)
			region = (i/3).floor
			region *= 3
			region += (j/3).floor
		end
		return region
	end

end