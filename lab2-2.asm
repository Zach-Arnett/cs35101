#Zach Arnett

.data
	x: .word 0
	xPrompt: .asciiz "Enter an integer for x: "
	xValue: .asciiz "\nThe Value of x is: "
	y: .word 0
	yPrompt: .asciiz "Enter an integer for y: "
	yValue: .asciiz "\nThe Value of y is: "
	
.text
main:
#Print prompt for x
	li $v0, 4
	la $a0, xPrompt
	syscall
#Read int for x
	li $v0, 5
	syscall
	move $s0, $v0
#Print prompt for y
	li $v0, 4
	la $a0, yPrompt
	syscall
#Read int for y
	li $v0, 5
	syscall
	move $s1, $v0
	
#swap $s0 and $s1 using $t0
	move $t0, $s0
	move $s0, $s1
	move $s1, $t0
	
#Print text for x
	li $v0, 4
	la $a0, xValue
	syscall
#Print the value of x
	li $v0, 1
	move $a0, $s0
	syscall
#Print text for y
	li $v0, 4
	la $a0, yValue
	syscall
#Print the value of y
	li $v0, 1
	move $a0, $s1
	syscall
#Exit 
     li   $v0, 10
     syscall
	