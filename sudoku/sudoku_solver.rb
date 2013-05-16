#!/usr/local/bin/ruby -w

require_relative 'board'

class Sudoku_Solver

	# constructor
	def initialize (board)
		@board = board
		@b_solvable = board_unique
	end

	#solve sudoku board
	def solve
		puts "Original Board: "
		@board.print_board
		puts "\n"

		if !@b_solvable
			puts "Board is not solvable, the board provided with pre-populated values already breaks Sudoku rules"
		else
			puts "Begin solving"
			if solve_helper == false
				solve_helper2
			end
			puts "Solved board:"
			@board.print_board
		end
	end

	# Fill in squares where there's only 1 possibility.  Returns true if solved, false is not board isn't solved yet
	private
	def solve_helper
		num_empty_squares = 0;
		b_one_val_sq = false # represents whether squares were found having only 1 possible value, and them being set
		
		begin
			num_empty_squares = 0
			b_one_val_sq = false
			for i in 0..Sudoku_Board::SUDOKU_BOARD_DIMENSION-1
				for j in 0..Sudoku_Board::SUDOKU_BOARD_DIMENSION-1
					if @board.get_square(i,j) == "-"
						num_empty_squares+=1
						arr = available_vals(i,j)
						if arr.length == 1				
							
							# if only 1 possibility exists at an empty square, fill it in and move on
							@board.set_square(i,j,arr[0].to_s)
							num_empty_squares-=1
							b_one_val_sq = true
						end
					end
				end
			end
			# puts "num_empty_squares = ",num_empty_squares
			# puts "b_one_val_sq = ",b_one_val_sq
			# puts "modified board: "
			# @board.print_board
		end while num_empty_squares>0 and b_one_val_sq==true and board_unique==true # keep iterating when squares are modified and squares' available values need to be re-evaluated
		return num_empty_squares == 0
	end

	# Brute force algorithm to solve rest of board
	private 
	def solve_helper2
		
	end

	# Checks if values in rows/cols/regions are unique
	private
	def board_unique
		i = 0
		b_unique = true

		while b_unique && i < Sudoku_Board::SUDOKU_BOARD_DIMENSION
			b_unique = b_unique and check_row_unique(i) and check_col_unique(i) and check_region_unique(i)
			i += 1
		end
		return b_unique
	end

	# Check if board row has duplicate value
	# Params :
	# 	r = row number of board to check
	private
	def check_row_unique(r)
		arr = @board.get_row(r)
		return has_unique_vals(arr)
	end

	# Check if board column has duplicate value
	# Params :
	# 	c = column number of board to check
	private
	def check_col_unique(c)
		arr = @board.get_col(c)
		return has_unique_vals(arr)
	end

	# Check if board regino has duplicate value
	# Params :
	# 	reg_num = region number of board to check
	private
	def check_region_unique(reg_num)
		arr = @board.get_region(reg_num)
		return has_unique_vals(arr)
	end

	# Check for duplicate value in array
	# ParamS :
	# 	arr = array to check
	private
	def has_unique_vals(arr)
		arr.sort!
		valid = true
		i = 0
		while i < Sudoku_Board::SUDOKU_BOARD_DIMENSION-2 && valid
			if arr[i] != "-"  && arr[i+1] != "-" && arr[i] == arr[i+1]
				valid = false
			end
			i+=1
		end

		return valid
	end

	# Return array of available values for a given board square
	# 	r = row of square to check
	# 	c = col of square to check
	private
	def available_vals (r,c)
		if @board.get_square(r,c) == "-"
			used_values = [@board.get_row(r),@board.get_col(c),@board.get_region(Sudoku_Board::coord_to_region(r,c))]  
			used_values.flatten!
			
			# keep track of which values are used
			arr_val_map = Array.new(9,0)
			for i in 0..used_values.length-1
				if used_values[i] != "-"
					arr_val_map[used_values[i].to_i - 1] += 1
				end
			end

			avail_values = []
			for i in 0..arr_val_map.length-1
				avail_values.push(i+1) if arr_val_map[i]==0
			end
			return avail_values
		else
			return nil
		end
	end
end