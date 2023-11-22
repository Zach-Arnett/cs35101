#Zach Arnett
.data
	numPrompt: .asciiz "How many numbers would you like to average? "
	entryPrompt: .asciiz "Please enter a 3 digit decimal d.dd: "
	avgOutput: .asciiz  "The average is: "
	
.text
main:
#Print the prompt for number of loops
	li $v0, 4
	la $a0, numPrompt
	syscall
#Read the number of loops as an int in $t0
	li $v0, 5
	syscall
	move $t0, $v0
	
Loop:
#Print the prompt for entry
	li $v0, 4
	la $a0, entryPrompt
	syscall
#Read the entry as a float in  $f0
	li $v0, 6
	syscall
#add entry to sum in $f1
	add.s $f1, $f1, $f0
#increment current loop value
	addi $t1, $t1, 1
#If current loop num >= total loop num, continue. Else, go to Loop
	blt $t1, $t0, Loop

#Average
#Convert num of loops to float
	mtc1 $t0, $f2
	cvt.s.w $f2, $f2
#Divide for average
	div.s $f1, $f1, $f2

#Print the prompt for output
	li $v0, 4
	la $a0, avgOutput
	syscall
#Print the output float
	mov.s $f12, $f1
	li $v0, 2
	syscall

#Exit
	li $v0, 10
	syscall
	
