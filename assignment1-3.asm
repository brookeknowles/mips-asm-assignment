# Template code for Question 3 (Assignment 1) 
# DO NOT use pseudo instructions (except la if necessary)  

			.data
	str0:	.asciiz	"Enter the value for n: "		
	str1:	.asciiz	"Fibonacci sequence is: "
	str2:	.asciiz	", "
 

			.text 
			.globl	    main
	main: 

		# set up the stack frame if needed 
		addiu $sp, $sp, -8
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)

		# initalise variables/consts
		ori $s0, $0, 1 			# initalise i = 1

		# print the initial message 
		ori $v0, $0, 4 			# system call code for printing a string
		la $a0, str0 			# print the message from str0
		syscall

		# Getting user input for n
		ori $v0, $0, 5	 		# system call code for reading an integer
		syscall
		addu $s1, $0, $v0 		# Moving the integer input to s1 register
				
		# print the message "Fibonacci sequence is: "
		ori $v0, $0, 4 			# system call code for printing a string
		la $a0, str1 			# print the message from str1
		syscall
		
		j loopN 				# go to loop
		
	loopN:
		# loops through the numbers from 1 to n
		add $a0, $0, $s0 			# add i value to a0 register
		jal fibonacci 				# go to fibonacci function
		

		# print the actual number
		# MEMORY ADDRESS OUT OF BOUNDS ERROR HERE 
		move $a0, $v1
		ori $v0, $0, 4 				# system call code for printing an integer
		syscall

		# print the comma and space between 2 numbers
		ori $v0, $0, 4 				# system call code for printing a string
		la $a0, str2 				# print the message from str2
		syscall

		addi $s0, $s0, 1 			# add 1 to i
		beq $s0, $s1, exitMain		# if i == n, exit
		j loopN 					# else if i < n, loop again

	exitMain:
		# release the stack frame
		lw $ra, 0($sp)				# restore ra register from stack frame
		lw $s0, 4($sp)				# restore s0 register from stack frame
		lw $s1, 8($sp)				# restore s1 register from stack frame
		addiu $sp, $sp, 8 			# deallocate 2 words on the stack frame

		# Exit to SPIM 
		addi	$v0, $0, 10			# system call code for  exit 
		syscall						# exit: end of the program execution?
		

  
  fibonacci:
		# n = $a0
		# value to return = $v1

		# set up the stack frame
		addiu $sp, $sp, -8			# allocate 2 words on the stack (since int = 1 word = 4 bytes, and n < 12 means max 2 ints)
		sw $ra, 0($sp)				# save ra register in the stack frame
		sw $a0, 4($sp)				# save a0 register in the stack frame
		sw $s0, 8($sp)				# save s0 register in the stack frame

		ori $v1, $0, 0 			# initialise return value to 0
		ori $s0, $0, 0 			# initialise s0 register to 0

		j nIs0   					# go to first if statement
		
	nIs0:	
		# first if statement of the C code: if (n < 1) return 0;
		slti $t0, $a0, 1 			# if a0 (n) < 1, set t0 register to 1
		beq $t0, $0, nIs1or2		# if t0 == 0 (i.e. n >= 1), then go to nIs1or2
		ori $v1, $0, 0				# set return value to 0
		j exitFib					# sequence has been found so go to exitFib
			
	nIs1or2:
		# second if statement of the C code: if (n == 1 || n == 2) return 1;
		ori $t0, $0, 3 			# set t0 to 3
		slti $t1, $a0, 3 			# if a0 (n) < 3, set t1 to 1
		beq $t1, $0, nGreaterThan2 	# if t1 == 0 (i.e. n != 1 or 2), then go to nGreater than 2
		ori $v1, $0, 1				# set return value to 1
		j exitFib					# sequence has been found so go to exitFib

	nGreaterThan2:
		# final else statement of the C code: return fibonacci(n-1) + fibonacci(n-2)
		addi $a0, $a0, -1 			# subtract 1 from a0 (i.e. n-1)
		jal fibonacci 	 			# call fibonacci function on n-1
		add $s0, $s0, $v1			# add the value from n-1 call
		addi $a0, $a0, -1 			# subtract another 1 from a0 (i.e. n-2)
		jal fibonacci 	 			# call fibonacci function on n-2
		add $s0, $s0, $v1			# add the value from n-2 call

	exitFib:
		# release the stack frame and return the result
		lw $ra, 0($sp)				# restore ra register from stack frame
		lw $a0, 4($sp)				# restore a0 register from stack frame
		lw $s0, 8($sp)				# restore s0 register from stack frame
		addiu $sp, $sp, 8 			# deallocate 2 words on the stack frame
		jr $ra						# go to return address