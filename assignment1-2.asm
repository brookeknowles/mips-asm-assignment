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
		ori $t5, $0, 0 			# initalise j to 0 and store in t5 register	
		ori $t6, $0, 0 			# initalise j to 0 and store in t6 register	

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
			# Outer loop of the nested loops (the i part)
			# Loop through the characters of input string. If str[i] == 't', then go into middle loop 

		middle_loop:
			# Middle loop of the nested loops (the j part)
			# Loop through characters of input string. If str[j] == 'h', then go to inner loop

		inner_loop:
			# Innermost loop of the nested loops (the k part)
			# Loop through characters of input string. If str[k] == 'e', then "the" word found so increase counter
		
		exit_inner:
			# exit out of the inner loop

		exit_middle:
			# exit out of middle loop
			
		exit_outer:
			# exit out of the outer loop
			j Exit

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

