.data

 n: .word 10
 msg: .asciiz "The result is: "

.text

main:
	addi $a0,$zero, 10 
	jal fib
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
fib:
	addi $sp, $sp, -12		# make stack
	sw	$s0, 0($sp)		# save $s0
	sw	$ra, 4($sp)		# save address
	sw	$a0, 8($sp)		# save n
	
	slti $t0, $a0, 2		# fib(i) = i for i = 0, 1
	beq	$t0, $0, else
	add	$v0, $a0, $0		# $v0 = 0 or 1
	j   exit			# go to exit
else:
	addi	$a0, $a0, -1		# fib(n-1)
	jal	fib			# recursive call
	add	$s0, $v0, $0
	addi	$a0, $a0, -1		# fib(n-2)
	jal	fib			# recursive call
	add	$v0, $v0, $s0
exit:
	lw	$s0, 0($sp)		# restore $s0
	lw	$ra, 4($sp)		# restore return address
	lw	$a0, 8($sp)		# restore $a0
	addi	$sp, $sp, 12# free stack frame
	jr	$ra			    # return to caller

	
	
