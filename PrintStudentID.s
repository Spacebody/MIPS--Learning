# function : use mips output to print student ID	
.data
	# varibale declarations here
	msg: .asciiz "My student ID is XXXXXXX.\n"
	
.text
.globl main
	main:  # start of code
	li $v0, 4  # load the code for print_string
	la $a0, msg # load arg 
	syscall   # excute the code
	li $v0, 10 # load 10 to v0 
	syscall  # call to indicate the end of program
