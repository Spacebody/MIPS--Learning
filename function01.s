.data
	x: .word 0
	y: .word 0
	z: .word 0
	hello: .asciiz "Compute the result of x^2+y^2+z^2+xy+yz+xz\n"
	msgx: .asciiz "Plz enter an integer less than 20 for x: "
	msgy: .asciiz "Plz enter an integer less than 20 for y: "
	msgz: .asciiz "Plz enter an integer less than 20 for z: "
	err: .asciiz "Too large, enter again: "
	result: .asciiz "The result of x^2+y^2+z^2+xy+yz+xz is: "
	again: .asciiz "Result is larger than 400, restart.\n"

.text

main:
	li $v0, 4
	la $a0, hello
	syscall
	la $a0, msgx
	syscall #print message
	jal assign
	sw $v0, x #store value for x
	li $v0, 4
	la $a0, msgy
	syscall #print message
	jal assign
	sw $v0, y #store value for y
	li $v0, 4
	la $a0, msgz
	syscall #print message
	jal assign
	sw $v0, z #store value for z

	lw $a0, x #load word
	lw $a1, y
	lw $a2, z
	mul $t0, $a0, $a0 #x^2
	mul $t1, $a1, $a1 #y^2
	add $t0, $t0, $t1 #x^2+y^2
	mul $t1, $a2, $a2 #z^2
	add $t0, $t0, $t1 #x^2+y^2+z^2
	mul $t1, $a0, $a1 #xy
	add $t0, $t0, $t1 #x^2+y^2+z^2+xy
	mul $t1, $a1, $a2 #yz
	add $t0, $t0, $t1 #x^2+y^2+z^2+xy+yz
	mul $t1, $a0, $a2 #xz
	add $t0, $t0, $t1 #x^2+y^2+z^2+xy+yz+xz

	slti $t1, $t0, 400
	beq $t1, 1, print #less than 400, jump to print
	li $v0, 4
	la $a0, again
	syscall
	bne $t1, 1, main #else restart


#loop to ensure 
assign:li $v0, 5 #read an integer
	   syscall
	   slti $t0, $v0, 20 #set if less than 20
	   beq $t0, 1, back
	   bne $t0, 1, errout
#print out error message
errout:li $v0, 4
	   la $a0, err
	   syscall
	   j assign

#jump back
back:jr $ra

#print result and exit
print:li $v0, 4
	  la $a0, result
	  syscall
	  li $v0, 1
	  move $a0, $t0
	  syscall
	  li $v0, 10 #exit 
	  syscall