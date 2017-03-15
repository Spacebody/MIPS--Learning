.data
	hello: .asciiz "Compute the result of x^2+y^2+z^2+xy+yz+xz\n"
	result: .asciiz "The result of x^2+y^2+z^2+xy+yz+xz is:\n "
	newline: .asciiz "\n"
.text
main:
	li $v0, 4
	la $a0, hello
	syscall
	la $a0, result
	syscall

	#setup parameters
	li $a0, 1 #x = 1
	li $a1, 1 #y = 1
	li $a2, 1 #z = 1 

	move $s0, $a0 # x = 1
	jal LoopX

	li $v0, 10
	syscall

LoopX:
	addi $sp, $sp, -4
	sw $ra, 0($sp) #store address
	
	move $s1, $a1 # y = 1
	jal LoopY

	lw $ra, 0($sp) #load address
	addi $sp, $sp, 4

	addi $s0, $s0, 1 # ++x
	slti $t0, $s0, 20 # x<20?1:0 
	bne $t0, $zero, LoopX 
	jr $ra
LoopY:
	addi $sp, $sp, -4
	sw $ra, 0($sp)#store address
	
	move $s2, $a2 # z = 1
	jal  LoopZ

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	addi $s1, $s1, 1 # ++y
	slti $t0, $s1, 20 # y<20?1:0 
	bne $t0, $zero, LoopY 
	jr $ra
LoopZ:
	addi $sp, $sp, -4
	sw $ra, 0($sp)#store address
	
	jal  Result #jump compute result

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	addi $s2, $s2, 1 # ++z
	slti $t0, $s2, 21 # z<20?1:0 
	bne $t0, $zero, LoopZ 
	jr $ra
Result:
	mul $t0, $s0, $s0 #x^2
	add $s3, $zero, $t0
	mul $t0, $s1, $s1 #y^2
	add $s3, $s3, $t0
	mul $t0, $s2, $s2 #z^2
	add $s3, $s3, $t0
	mul $t0, $s0, $s1 #xy
	add $s3, $s3, $t0
	mul $t0, $s1, $s2 #yz
	add $s3, $s3, $t0
	mul $t0, $s0, $s2 #xz
	add $s3, $s3, $t0 #result
	
	slti $t1, $s3, 401 #result < 401 ? 1 : 0 
	bne $t1, $zero, Print
	jr $ra
Print:
	li $v0, 1 # print integer
	move $a0, $s3  
	syscall
	li $v0, 4
	la $a0, newline #print newline
	syscall
	jr $ra