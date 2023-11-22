#Zach Arnett

.data
	fPrompt: .asciiz "\nEnter a value for f: "
	gPrompt: .asciiz "Enter a value for g: "
	calculation: .ascii "Answer for f = g - (f + 5): "

.text
Beginning:
#Keep count of repeats
	addi $t1, $t1, 1

#Prompt the user to enter values for f and g
#Print the prompt for f
	li $v0, 4
	la $a0, fPrompt
	syscall
#Read the input for f
	li $v0, 5
	syscall
	move $s1, $v0
#Print the prompt for g
	li $v0, 4
	la $a0, gPrompt
	syscall
#Read the input for g
	li $v0, 5
	syscall
	move $t0, $v0

#Calculates f = g-(f+5)
#Assign f = (f+5)
	addi $s1, $s1, 5
#Assign f = g-(f+5)
	sub $s1, $t0, $s1

#Prints the result of f = g-(f+5)
#Print the text for f = g-(f+5)
	li $v0, 4
	la $a0, calculation
	syscall
#Print the final value of f
	li $v0, 1
	move $a0, $s1
	syscall

#Repeat for a total of 3 times
	bne $t1, 3, Beginning

#Exit 
     li   $v0, 10
     syscall