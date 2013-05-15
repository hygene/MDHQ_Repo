#include <stdio.h>
#include <string.h>

/*
Function to calculate and return factorial of x
Params:
 x - Input used to calculate factorial.  If input is negative, then return -1.
 */
int factorial( int x ) {
    int output = -1;
    if (x >= 0) {
    	output = 1;
		int i;
		for(i=x; i>=1; i--) {
			output *= i;
		}
	}
	return output;
}

main()
{  
	/*Test cases for negative numbers, 0, and positive numbers*/
	int arr[6] = {-10, -1, 0, 1, 4, 10};
	int arr_len = 6;
    int i;
	for(i=0; i < arr_len; i++) {
		printf("factorial(%d) = %d \n", arr[i], factorial(arr[i]));	
	}
}
