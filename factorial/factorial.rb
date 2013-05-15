#!/usr/local/bin/ruby -w

=begin
Function to calculate and return factorial of x
Params:
 x - Input used to calculate factorial.  If input is negative or not an integer, then return -1.
=end
def factorial(x)
	output = -1

	# check if input is integer
	is_int = x.kind_of? Integer
	if is_int && x >= 0
		output = 1
		for i in 1..x
			output *= i
		end	
	end
	return output
end

#Test cases for negative numbers, 0, and positive numbers
[-10,-1,0,1,4,10,"arst"].each { |e| print "factorial(",e,") = ",factorial(e),"\n"  }
