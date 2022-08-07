# Template code for Question 3 (Assignment 1) 
# DO NOT use pseudo instructions (except la if necessary)  

			.data
	str0:	.asciiz	"Enter the value for n: "		
	str1:	.asciiz	"Fibonacci sequence is: "
	str2:	.asciiz	", "
 

			.text 
			.globl	    main
	main: 

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
		
	exitMain:
		# Exit to SPIM 
		addi	$v0, $0, 10			# system call code for  exit 
		syscall						# exit: end of the program execution?

	loopN:
		# loops through the numbers from 1 to n
		add $a0, $0, $s0 			# add i value to a0 register
		jal fibonacci 				# go to fibonacci function

		# print result
		add $a0, $0, $v0
		addi $v0, $0, 1
		syscall

		# print ','
		addi $v0, $0, 4
		la $a0, str2
		syscall

		addi $s0, $s0, 1 			# add 1 to i
		beq $s0, $s1, exitMain		# if i == n, exit
		j loopN 					# else if i < n, loop again
  
  fibonacci:
		# input argument: $a0 (n in the c code)
		
		# set up the stack frame if needed 
		addi $sp, $sp, -12
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)

		add $s0, $a0, $zero

		addi $t1, $zero, 1
		beq $s0, $zero, return0
		beq $s0, $t1, return1

		addi $a0, $s0, -1

		jal fibonacci

		add $s1, $zero, $v0     # s1=fib(n-1)

		addi $a0, $s0, -2

		jal fibonacci               # v0=fib(n-2)

		add $v0, $v0, $s1       # v0=fib(n-2)+$s1

		exitfib:
			lw $ra, 0($sp)       # read registers from stack
			lw $s0, 4($sp)
			lw $s1, 8($sp)
			addi $sp, $sp, 12       # bring back stack pointer
			jr $ra

		return1:
			li $v0, 1
			j exitfib

		return0:     
			li $v0, 0
			j exitfib
