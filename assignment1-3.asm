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
		

		# print the initial message and read the value of n 
		
				# your code ...
				
		# print the message and result numbers
		
		
				# your code ...
		
		
		
		# Exit to SPIM 
		addi	$v0, $0, 10			# system call code for  exit 
		syscall						# exit: end of the program execution?
		

  
  fibonacci:
		# input argument = register $t0

		# set up the stack frame if needed 
		addiu $sp, $sp, -8		# allocate 2 words on the stack (since int = 1 word = 4 bytes, and n < 12 means max 2 ints)
		sw $ra, 0($sp)			# save ra register in the stack frame
		sw $t0, 4($sp)			# save t0 register in the stack frame
			# your code ... 
			
  
		# return the result 
		
			# your code ... 


		# release the stack frame
		lw $ra, 0($sp)			# restore ra register from stack frame
		lw $t0, 4($sp)			# restore t0 register from stack frame
		addiu $sp, $sp, 8 		# deallocate 2 words on the stack frame
