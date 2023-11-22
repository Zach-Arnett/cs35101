#Zach Arnett
.data
	sumValue: .asciiz "The Sum is: "
	
	xPrompt: .asciiz "Enter an integer for x: "
	yPrompt: .asciiz "Enter an integer for y: "
	zPrompt: .asciiz "Enter an integer for z: "
	
.text
main:
#Print prompt for x
	li $v0, 4
	la $a0, xPrompt
	syscall
#Read int for x
	li $v0, 5
	syscall
	move $t0, $v0
#Print prompt for y
	li $v0, 4
	la $a0, xPrompt
	syscall
#Read int for y
	li $v0, 5
	syscall
	move $t1, $v0
#Print prompt for z
	li $v0, 4
	la $a0, xPrompt
	syscall
#Read int for z
	li $v0, 5
	syscall
	blt $t0, $t1, xLess

#if y < x
#if z < y, jump to sum
	blt $v0, $t1, sum
#if y > z, y <- z
	move $t1, $v0
	j sum

#if x < y
xLess:
#if z < x, jump to sum
	blt $v0, $t0, sum
#if x > z, x <- z
	move $t0, $v0
	j sum

sum:
#Sum two largest ints
	add $s0, $t0, $t1
#Print Text for Sum
	li $v0, 4
	la $a0, sumValue
	syscall
#Print Sum
	li $v0, 1
	move $a0, $s0
	syscall
#Exit 
     li   $v0, 10
     syscall