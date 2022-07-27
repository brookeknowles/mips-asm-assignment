# Template code for Question 2 (Assignment 1) 
# DO NOT use pseudo instructions (except la if necessary)  

				.data 
	prompt1:	.asciiz		"Enter a string of characters: "
	prompt2:	.asciiz		"\n ... number of word 'the' in the string is: "
	# reserve a buffer to store up to 200 characters for the input string 
				# (plus one for 0 at the end of the string)
	str_buf: 	.space		201  
  
 
	# other things here if needed ...


			.text 
			.globl	    main
	main: 
		# no need for stack frame 

		# Print the prompt message and enter the string from keyboard 
			# your code ...
		
			
	Exit:
		# Print the result
			# your code ...
		
		# Exit to SPIM 
		addi	$v0, $0, 10			# system call code for  exit 
		syscall						# exit: end of the program execution?

