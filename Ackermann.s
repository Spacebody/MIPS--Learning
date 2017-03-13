.data
	hello: .asciiz "Compute Ackermann's function A(x,y):\n"
	msgx: .asciiz "Enter an integer for x: " 
	msgy: .asciiz "Enter an integer for y: "
	result: .asciiz "The result is: "
.text
main:
	addi $sp, $sp, -16 #make stack to store
	sw $ra, 0($sp) #store address
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
#hello message
	li $v0, 4 #print string
	la $a0, hello #print hello message
	syscall
#message for input	
	la $a0, msgx
	syscall
	li $v0, 5 #read an integer
	syscall
	move $s0, $v0 #store x
	li $v0, 4 #print string
	la $a0, msgy
	syscall
	li $v0, 5
	syscall
	move $s1, $v0  #store y
#setup parameters for function	
	move $a0, $s0 #pass paraeter x
	move $a1, $s1 #pass y
	
	jal Ackermann #call function

#after computing, print out result
	move $a2, $v0
	addi $sp, $sp, -4 
	sw $a0, 0($sp)

	li $v0, 4
	la $a0, result 
	syscall

	li $v0, 1 #print integer
	move $a0, $a2 #move result to be printed
	syscall
 
	lw $a0, 0($sp) #restore
	addi $sp, $sp, 4

#restore stack
	lw $ra, 0($sp) 
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16
#exit program
	li $v0, 10
	syscall


Ackermann:
	addi $sp, $sp, -8
	sw $s0, 4($sp) #save register
	sw $ra, 0($sp) #save address

#if x = 0
xZero:
	bne $a0, $zero, yZero #if x != 0, then check y
	#else
	addi $v0, $a1, 1
	j end #jump to end


yZero:
	bne $a1, $zero, bothLarger #if x and y are both larger than 0, then jump to third case
	addi $a0, $a0, -1
	add $a1, $zero, 1
	jal Ackermann #go to compute A(x-1, 1)
	j end

bothLarger:
	add $s0, $a0, $zero #save x
	#A(x, y-1)
	addi $a1, $a1, -1 # y-1
	jal Ackermann
	#A(x-1, A(x, y-1))
	addi $a0, $s0, -1
	add $a1, $v0, $zero #pass A(x, y-1) as parameters  
	jal Ackermann
	j end

end:
	lw $s0, 4($sp) 
	lw $ra, 0($sp) #restore address
	addi $sp, $sp, 8 #restore stack
	jr $ra #return to function