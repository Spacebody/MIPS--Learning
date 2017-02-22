# funtcion to compute f
.data
  str1: .asciiz "Please enter a integer:\n"
  str2: .asciiz "f=(a+b)+(c-d)\nResult: "
  num: .word 0
.text
main:
  li $v0, 4    # print string
  la $a0, str1
  syscall        
  li $v0, 5
  syscall
  sw $v0, num
  lw $t0, num

  li $v0, 4    
  la $a0, str1
  syscall       
  li $v0, 5
  syscall
  sw $v0, num
  add $t0, $t0, $v0

  li $v0, 4    
  la $a0, str1
  syscall        
  li $v0, 5
  syscall
  sw $v0, num
  add $t0, $t0, $v0

  li $v0, 4    
  la $a0, str1
  syscall        
  li $v0, 5
  syscall
  sw $v0, num
  sub $t0, $t0, $v0

  li $v0, 4
  la $a0, str2
  syscall
  li $v0, 1
  move $a0, $t0 # move result to be printed
  syscall

  li $v0, 10
  syscall