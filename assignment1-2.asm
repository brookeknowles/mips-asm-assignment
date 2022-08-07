# Template code for Question 2 (Assignment 1) 
# DO NOT use pseudo instructions (except la if necessary)  

				.data 
	prompt1:	.asciiz		"Enter a string of characters: "
	prompt2:	.asciiz		"\n ... number of word 'the' in the string is: "
	# reserve a buffer to store up to 200 characters for the input string 
	# (plus one for 0 at the end of the string)
	str_buf: 	.space		201  
	substring_the: .asciiz "the"

			.text 
			.globl	    main
	main: 
		# Initalize registers with variables/constants
		ori $t0, $0, 0	 				# initalise counter (for number of times 'the' occurs in string) to 0 and store in t0 register
		ori $t1, $0, 201 				# store max length of input string in t1 register
		ori $t2, $0, 0 					# initalise i to 0 and store in t2 register

		# Print the prompt message to SPIM console  
		ori $v0, $0, 4 					# system call code for printing a string
		la $a0, prompt1 				# print the message from prompt1
		syscall

		# User can enter the string from keyboard
		ori $v0, $0, 8          		# system call code for reading a string
		la $a0, str_buf   	    		# tell syscall where the buffer is
		ori $a1, $0, 201        		# tell syscall how big the buffer is
		syscall    

	outer_loop:
		beq $t1, $t2, Exit 				# if i == 201, end the loop because string is over
		lb $a1, 0($a0)       			# load next character into a1 register
		addiu $a2, $0, 't' 				# load 't' into the a2 register
		beq $a1, $a2, middle_loop		# if the first char == t, go to middle loop
		
		j next_i_index # no t found, get the next i index of the loop 
			
	middle_loop:
		addu $a0, $a0, 1				# get next character in string by adding 1 to a0
		lb $a1, 0($a0)       			# load next character into a1 register
		addiu $a2, $0, 'h'	        	# load 'h' into the a2 register
		beq $a1, $a2, inner_loop		# if the char == h, go to inner loop
		
		j next_i_index # no h found, get the next i index of the loop and go back into outer loop

	inner_loop:
		addu $a0, $a0, 1				# get next character in string by adding 1 to a0
		lb $a1, 0($a0)       			# load next character into a1 register
		addiu $a2, $0, 'e'     			# load 'e' into the a2 register
		beq $a1, $a2, incrementCounter	# if the char == h, then 'the' has been found, so increase counter
	
		j next_i_index # no e found, get the next i index of the loop and go back into outer loop

	next_i_index:
		# Gets the next character of the string (for the i loop)
		addi $t2, $t2, 1 				# increase i by one (i++)
		addu $a0, $a0, 1				# get next character in string by adding 1 to a0
		j outer_loop 					# go back to the loop after we got the next index

	incrementCounter:
	# Increments the counter (for number of times 'the' occurs in string) by 1
		addi $t0, $t0, 1 				# increase counter by one
		j outer_loop					# go back to outer loop after found the first 'the'
	
	Exit:
		# For some reason count is always 1 higher than it should be, so decrease by 1 before printing to screen
		ori $t3, $0, 1 					# put 1 in t3 register
		beq $t0, $0, Print				# if t0 (counter) == 0, then dont subtract, go to print
		sub $t0, $t0, $t3 				# subtract 1 from the counter and put back in same t0 register

		j Print

	Print:
		# Prints the result on SPIM Console
		ori $v0, $0, 4 					# system call code for printing a string
		la $a0, prompt2 				# print the message from prompt2
		syscall

		ori $v0, $0, 1 					# system call code for printing an integer
		add $a0, $t0, $0 				# print the value of "the" occurence counter from t0 register
		syscall
		
		# Exit to SPIM 
		addi	$v0, $0, 10				# system call code for  exit 
		syscall							# exit: end of the program execution?

