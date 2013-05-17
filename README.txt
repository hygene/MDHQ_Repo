
********************************************
Sudoku Readme
********************************************

[Files]
sudoku.rb - main entry point of program
sudoku_csv_validator.rb - validates CSV is in proper format
sudoku_solver.rb - solves Sudoku board
board.rb - class representing Sudoku board


[Use]
Execute 'ruby sudoku.rb <CSV filename>'
Example: ruby sudoku.rb sudoku_input_1.csv


[Output]
Original board, then solved board is printed out to STDOUT for comparison.  Example:

Original Board: 
-,1,-,-,-,5,6,-,-
-,8,-,9,6,4,-,-,1
7,-,-,-,-,-,5,-,-
-,3,4,-,8,7,-,1,-
6,5,1,-,-,-,3,8,7
-,2,-,1,3,-,4,5,-
-,-,3,-,-,-,-,-,4
5,-,-,6,4,8,-,7,-
-,-,8,7,-,-,-,2,-

Solved board:
3,1,9,8,7,5,6,4,2
2,8,5,9,6,4,7,3,1
7,4,6,3,2,1,5,9,8
9,3,4,5,8,7,2,1,6
6,5,1,4,9,2,3,8,7
8,2,7,1,3,6,4,5,9
1,7,3,2,5,9,8,6,4
5,9,2,6,4,8,1,7,3
4,6,8,7,1,3,9,2,5


[Questions from PDF]
[1] Sudoku_Solver::solve will first fill in any squares where there's only 1 possible value to fill in.  This operation will keep executing until the puzzle is either solved or there are no more squares left where only 1 possible value exists.  Once these squares are handled, use brute force to fill in rest of board.  Essentially for each empty square, try it's first available value.  Recursively move on to next empty square to try it's available value, when there's a dead end then backtrack while emptying out previously written squares until a square is reached where another value can be attempted.

[2] For the first sweep through of continually filling in empty squares with only 1 available value until none are left :
	best - O(n).  Either all empty squares have only 1 available value, or they all have multiple values
	worst - O(n!).  On each scan of empty squares, only 1 empty square has 1 available value to set
	expected - 	Hard to say given much depends on variations of boards.  If just going off of providing middlegruond between best and worst, then O(log(n)), where on each scan roughly half of the empty squares can be eliminated.  Similiar to searching a balanced BST where half the possibilities are eliminated each level traveled down.

	For the potential second sweep through utilizing backtracking :
	best - O(n).  Solver travels down the remaining empty squares setting the correct values along the way
	worst - O(n^m).  n = number of empty squares, m = number of available values per empty square.  Solver travels through each empty square having to backtrack and try every single combination of available values.
	expected - O(n^log(m)).  Each of the n empty square still needs to be traversed.  I suppose the m might become log(m) in an average case where only half the available values need to be attempted per square, eliminating the other half of potential branches, until the board is solved.

[3] Language - I chose Ruby because I had wanted to learn it anyways and this seemed like a good opportunity to jump in.  I had picked up Perl previously and figured it be similar enough to where I could have something built relatively rapidly. 

	Algorithm - Rather than trying to execute a backtracking algorithm starting at the very 1st empty square with all different possibilities, figured it'd be best to eliminate the obvious cases first by continually filling in squares with only 1 possible value until none remain and not have to travel down extraneous pathes.  If the puzzle hasn't been solved, then fall back on a backtracking algorithm.

	Classes - Sudoku_Board contains sudoku specific functions, which inherits from its Base class Board.  Board is there as base class to allow potential reuse.  The solver and validator classes are there so as to decouple these functionalities from the main program or the Board itself.  

[4] I definitely could have utilized unit testing ('test/unit') framework early on to save myself time in validating/debugging functions, but oversight on my part due to unfamiliarity with Ruby.  

	I could have created a seperate object representing a square on the board.  It might've made things easier to encapsulate functionality such as moving up/down/left/right from a square, setting it's available values if it's empty when solving the board, setting its region number, etc...  Only down side would have been the overhead of creating new objects, though not a serious concern here for such a small program.