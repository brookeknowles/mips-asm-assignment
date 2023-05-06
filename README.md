# CS304_A1

This was an assignment for a computer architecture course I took in university. Each file contains the MIPS assembly code for the following tasks:

### assignment1-1.asm: 
An array of 40 integer elements is stored in memory. Write the MIPS assembly instructions to count how many elements of the array are less than 0 and print the result on SPIM console.


### assignment1-2.asm: 
Write a MIPS assembly program that reads in a string of characters using the SPIM system call and finds how many words "the" are in the string and prints it on SPIM console. For example, there are *three* "the" words in the string "London is **the** capital and largest city of **the** United Kingdom. It stands on **the** River Thames." would result in "... number of word 'the' in the string is: 3" being printed on the console. The number of characters in the string is less than 200. 


### assignment1-3.asm: 
Using function **fibonacci(n)**, the sequence of numbers 1,1,2,3,5,8,13,21,... for values of **n** equal to 1,2,3,4,5,6,7,8,... can be generated. The function for each **n** is calculated as follows:

    fibonacci(1) = 1
    
    fibonacci(2) = 1
    
    fibonacci(n) = fibonacci(n-1) + fibonacci(n-2)    for n > 2
    
a. Write the MIPS assembly code for function fibonacci.
b. Write the main program, which reads the value of **n** from keyboard (n < 12) and prints the Fibonacci numbers up to the calculated value of **n** on SPIM console. For example, if **n** is 10, then the following sequence will be printed: 1,1,2,3,5,8,13,21,34
