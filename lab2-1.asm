#Zach Arnett
.data
	xValue: .asciiz "The Value of x is: "
	
	w: .word 0
	wPrompt: .asciiz "Enter an integer for w: "
	x: .word 0
	xPrompt: .asciiz "Enter an integer for x: "
	y: .word 0
	yPrompt: .asciiz "Enter an integer for y: "
	z: .word 0
	zPrompt: .asciiz "Enter an integer for z: "
	
.text
main:
#Print prompt for w
	li $v0, 4
	la $a0, wPrompt
	syscall
#Read int for w
	li $v0, 5
	syscall
	move $s0, $v0
#Print prompt for x
	li $v0, 4
	la $a0, xPrompt
	syscall
#Read int for x
	li $v0, 5
	syscall
	move $s1, $v0
#Print prompt for y
	li $v0, 4
	la $a0, yPrompt
	syscall
#Read int for y
	li $v0, 5
	syscall
	move $s2, $v0
#Print prompt for z
	li $v0, 4
	la $a0, zPrompt
	syscall
#Read int for z
	li $v0, 5
	syscall
	move $s3, $v0

#subtract (x-y), store in $t0
	sub $t0, $s1, $s2
	
#IF
#If (x-y)>=w, continue. Else, go to Else
	blt $t0, $s0, Else
#THEN
#Set x to y then jump to End
	move $s1, $s2
	j End
#ELSE
Else:
#Set x to z
	move $s1, $s3
#ENDIF
End:

#Print the text for x
	li $v0, 4
	la $a0, xValue
	syscall
#Print x
	li $v0, 1
	move $a0, $s1
	syscall
#Exit 
     li   $v0, 10
     syscall
	
	
