#!/usr/local/bin/ruby -w

require 'csv'
require_relative 'board'
require_relative 'sudoku_csv_validator'
require_relative 'sudoku_solver'

# read file name from STDIN
csv_name = ARGV[0]

arr_of_arrs = CSV.read(csv_name)

csv_validator = Sudoku_CSV_Validator.new(arr_of_arrs)

dim_valid = csv_validator.board_dim_valid
vals_valid = csv_validator.board_values_valid

if !dim_valid || !vals_valid
	puts "Please ensure the CSV file consists of 9 rows and 9 columns \n" if !dim_valid
	puts "Please ensure the CSV file contains only dashes and numbers [1-9] \n" if !vals_valid
else
	sboard = Sudoku_Board.new(arr_of_arrs)
	solver = Sudoku_Solver.new(sboard)
	solver.solve
end
