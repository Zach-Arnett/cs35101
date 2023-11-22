#Zach Arnett
.data
	entryPrompt: .asciiz "Enter an Integer (0 to Exit): "
	sumValue: .asciiz "The Sum is: "
	
.text
main:
#Print prompt for entry
	li $v0, 4
	la $a0, entryPrompt
	syscall
#Read int for entry
	li $v0, 5
	syscall
#Add entry to sum
	add $s0, $s0, $v0
	#move $s0, $v0
#Loop to Beginning if Entry is 0
bnez $v0, main

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
