# Template code for Question 3 (Assignment 1) 
# DO NOT use pseudo instructions (except la if necessary)  

			.data
	str0:	.asciiz	"Enter the value for n: "		
	str1:	.asciiz	"Fibonacci sequence is: "
	str2:	.asciiz	", "
 

			.text 
			.globl	    main
	main: 

		# initalise variables/consts
		ori $s0, $0, 1 				# initalise i = 1

		# print the initial message 
		ori $v0, $0, 4 				# system call code for printing a string
		la $a0, str0 				# print the message from str0
		syscall

		# Getting user input for n
		ori $v0, $0, 5	 			# system call code for reading an integer
		syscall
		addu $s1, $0, $v0 			# Moving the integer input to s1 register
				
		# print the message "Fibonacci sequence is: "
		ori $v0, $0, 4 				# system call code for printing a string
		la $a0, str1 				# print the message from str1
		syscall
		
		# n = 0 so just print the 0 not loop
		beq $s1, $0, nIsZero

		# n = 1 so just print the 1 not loop
		addi $t1, $0, 1				# initalise t1 register to 1
		beq $s1, $t1, nIsOne

		j loopN 					# n > 1 so go to loop
		
	nIsZero:
		# print zero
		add $a0, $0, 0				# store 0 in a0 register
		addi $v0, $0, 1	 			# system call code for printing an integer
		syscall

		j exitMain

	nIsOne:
		# print 1
		add $a0, $0, 1				# store 1 in a0 register
		addi $v0, $0, 1	 			# system call code for printing an integer
		syscall

		j exitMain

	exitMain:
		# Exit to SPIM 
		addi	$v0, $0, 10			# system call code for  exit 
		syscall						# exit: end of the program execution?

	loopN:
		# loops through the numbers from 1 to n
		add $a0, $0, $s0 			# add i value to a0 register
		jal fibonacci 				# go to fibonacci function

		# print the resulting number
		add $a0, $0, $v0			# fibonacci function saves result in v0 register, move to a0
		addi $v0, $0, 1	 			# system call code for printing an integer
		syscall

		# print print the comma and space between 2 numbers
		addi $v0, $0, 4				# system call code for printing a string
		la $a0, str2 				# print the message from str2
		syscall

		addi $s0, $s0, 1 			# add 1 to i
		beq $s0, $s1, exitMain		# if i == n, exit
		j loopN 					# else if i < n, loop again
  
  	fibonacci:
		# input argument: $a0 (n in the c code)
		
		# set up the stack frame if needed 
		addi $sp, $sp, -12			# allocate 12 bytes on the stack (since 1 int = 4 bytes, and n < 12 means max 2 ints will be used)
		sw $ra, 0($sp)				# save ra register in the stack frame
		sw $s0, 4($sp)				# save s0 register in the stack frame
		sw $s1, 8($sp)				# save s1 register in the stack frame

		add $s0, $0, $a0			# put n into the s0 register
		addi $t1, $0, 1				# initalise t1 register to 1 so can compare later

		beq $s0, $0, returnZero		# if n == 0, go to returnZero
		beq $s0, $t1, returnOne 	# if n == 1, go to returnOne

		addi $a0, $s0, -1			# store n - 1 in a0 register
		jal fibonacci				# call fibonacci function on n - 1
		add $s1, $0, $v0     		# store result of fibonacci(n-1) in s1 register

		addi $a0, $s0, -2			# store n - 2 in a0 register
		jal fibonacci               # call fibonacci function on n - 2
		add $v0, $v0, $s1       	# result of fibonacci(n-2) will be stored in v0 register, so add fibonacci(n-1) from s1 register

	exitFib:
		# release the stack frame and return the result
		lw $ra, 0($sp)       		# restore ra register from stack frame
		lw $s0, 4($sp)				# restore s0 register from stack frame
		lw $s1, 8($sp)	       		# restore s1 register from stack frame
		addi $sp, $sp, 12       	# bring back stack pointer
		jr $ra						# go to return address (where fibonacci was called last)

	returnOne:
		# second if statement of the C code: if (n == 1 || n == 2) return 1;
		ori $v0, $0, 1				# set return value to 1
		j exitFib					# sequence has been found so go to exitFib

	returnZero:
		# first if statement of the C code: if (n < 1) return 0;     
		ori $v0, $0, 0				# set return value to 0
		j exitFib					# sequence has been found so go to exitFib
