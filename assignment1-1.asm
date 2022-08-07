# Template code for Question 1 (Assignment 1) 
# DO NOT use pseudo instructions (except la if necessary)  

			.data
	str1:	.asciiz	" Number of negative numbers = "
			.align	4
	array1:	.word	100, 119, -30, 10, 0, -123, -2, 2233 
			.word	800, 0, -245, 18170, 0, 55, -1, -450
			.word	9800, 20000, -101, -66, -26, 0, 24590, 123
			.word	12345, 20, 304, 9, 450, -110, -321, 1020
			.word	-1102, 11111, -203, 0, 250, 2, -23, 8888
			# there are 14 negative numbers btw 
			.text
			.globl	 	main
			
	main:	
			# Initalize registers with variables/constants 
			ori $t0, $0, 40 		# store number of iterations in t0 register (size of array = 40)
			ori $t1, $0, 0 			# initalise loop index to i = 0 & store in t1 register
			ori $t2, $0, 0 			# initalise negative number counter to 0 and store in t2 register
			la $t3, array1 			# t3 register will store memory address of array1[i]. this line initalises with array1[0]

			loop:
			# Loops through the array
				beq $t0, $t1, end 	# if i == 40, end the loop
				lw $t4, ($t3)		# get value of array1[i] and store in t4 register
				slt $t5, $t4, $0	# check if array1[i] < 0, store result in t5 register (0 = false, 1 = true)
				bne $t5, $0, incrementCounter # if t5 != 0 (meaning previous line was true), go to incrementCounter
				j nextIndex 		# get the next index (array1[i+1])

			incrementCounter:
			# Increments the negative number counter by 1
				addi $t2, $t2, 1 	# increase counter by one
				j nextIndex 		# get the next index (array1[i+1])

			nextIndex:
			# Gets the next index of the array
				addi $t1, $t1, 1 	# increase i by one (i++)
				addi $t3, $t3, 4 	# get memory address of next element of array1 (4 since word = 4 bytes)
				j loop 				# go back to the loop after we got the next index

			end:
			# Prints the result on SPIM Console
				ori $v0, $0, 4 		# system call code for printing a string
				la $a0, str1 		# print the message from str1
				syscall

				ori $v0, $0, 1 		# system call code for printing an integer
				add $a0, $t2, $0 	# print the value of negative number counter from t2 register
				syscall
						
			# Exit to SPIM 
			addi	$v0, $0, 10		# system call code for  exit 
			syscall					# exit: end of the program execution?