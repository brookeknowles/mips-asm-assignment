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
		ori $t0, $0, 0 			# initalise counter (for number of times 'the' occurs in string) to 0 and store in t0 register
		ori $t1, $0, 3 			# store length of string "the" in t1 register
		ori $t2, $0, 201 		# store max length of input string in t2 register
		ori $t3, $0, 198        # store (length of input string - length of "the") in t3 register
		ori $t4, $0, 0 			# initalise i to 0 and store in t4 register

		# Print the prompt message to SPIM console  
		ori $v0, $0, 4 			# system call code for printing a string
		la $a0, prompt1 		# print the message from str1
		syscall

		# User can enter the string from keyboard
		ori $v0, $0, 8          # system call code for reading a string
		la $a0, str_buf   	    # tell syscall where the buffer is
		ori $a1, $0, 201        # tell syscall how big the buffer is
		syscall    

		# Move the string and print to console (testing purposes only)
		la $a0, str_buf  		# move buffer into a0 register 
		ori $v0, $0, 4          # print buffer (just to check its actually there, can delete later)
		syscall

		outer_loop:
			beq $t2, $t4, end 	# if i == 201, end the loop because string is over
		    lb $a1, 0($a0)       		# get first char of string and load into a1 register
			li $a2,'t'					# load 't' into the a2 register (PSEUDOINSTRUCTION PLS CHANGE)
			beq $a1, $a1, middle_loop	# if the first char == t, go to middle loop
			
			j next_i_index # no t found, get the next i index of the loop 
			 
		middle_loop:
			addu $a0, $a0, 1			# get next character in string by adding 1 to a0
			lb $a1, 0($a0)       		# load next character into a1 register
			li $a2,'h'					# load 'h' into the a2 register
			beq $a1, $a1, inner_loop	# if the char == h, go to inner loop
			
			j next_i_index # no h found, get the next i index of the loop and go back into outer loop

		inner_loop:
			addu $a0, $a0, 1				# get next character in string by adding 1 to a0
			lb $a1, 0($a0)       			# load next character into a1 register
			li $a2,'e'						# load 'e' into the a2 register
			beq $a1, $a1, incrementCounter	# if the char == h, then 'the' has been found, so increase counter
		
			j next_i_index # no e found, get the next i index of the loop and go back into outer loop

		next_i_index:
			# Gets the next character of the string (for the i loop)
				addi $t1, $t1, 1 	# increase i by one (i++)
				# need to figure out how to get character string[i]
				j outer_loop 				# go back to the loop after we got the next index

		incrementCounter:
		# Increments the counter (for number of times 'the' occurs in string) by 1
			addi $t2, $t2, 1 	# increase counter by one
	
	Exit:
		# Prints the result on SPIM Console
		ori $v0, $0, 4 		# system call code for printing a string
		la $a0, prompt2 	# print the message from prompt2
		syscall

		ori $v0, $0, 1 		# system call code for printing an integer
		add $a0, $t0, $0 	# print the value of "the" occurence counter from t0 register
		syscall
		
		# Exit to SPIM 
		addi	$v0, $0, 10			# system call code for  exit 
		syscall						# exit: end of the program execution?

