# function to print f, which take four integers
.data
str: .asciiz  "Compute f=(a+b)+(c-d)\na = 3, b = 4, c = 6, d = 9\nf = " 
var1: .word    3
var2: .word    4
var3: .word    6
var4: .word    9
.text
main:
	li $v0, 4 # load the code for print_string
	la $a0, str # load arg 
	syscall   # excute the code
	lw $t0, var1 # load value of a to register
	lw $t1, var2  # load value of b to register
	add $t0, $t0, $t1 # do an add operation
	lw $t1, var3   # load c to register
	add $t0, $t0, $t1 
	lw $t1, var4  # load d
	sub $t0, $t0, $t1 # do a sub operation 
	li $v0, 1  # load the code for print_int 
	move $a0, $t0
	syscall
	li $v0, 10 # load 10 to v0 
	syscall  # call to indicate the end of program
