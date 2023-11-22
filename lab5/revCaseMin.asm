# Zach Arnett
#
# Starter code for reversing the case of a 30 character input.
# Put in comments your name and date please.  You will be
# revising this code.
#
# Created by Dianne Foreback 
# Students should modify this code
# 
# This code displays the authors name (you must change
# outpAuth to display YourFirstName and YourLastName".
#
# The code then prompts the user for input
# stores the user input into memory "varStr"
# then displays the users input that is stored in"varStr" 
#
# You will need to write code per the specs for 
# procedures main, revCase and function findMin.
#
# revCase will to reverse the case of the characters
# in varStr.  You must use a loop to do this.  Another buffer
# varStrRev is created to hold the reversed case string.
# 
# Please refer to the specs for this project, this is just starter code.
#
# In MARS, make certain in "Settings" to check
# "popup dialog for input syscalls 5,6,7,8,12"
#
            .data      # data segment
	    .align 2   # align the next string on a word boundary
outpAuth:   .asciiz  "This is Zach Arnett presenting revCaseMin.\n"
outpPrompt: .asciiz  "Please enter 30 characters (upper/lower case mixed):\n"
	    .align 2   #align next prompt on a word boundary 
outpStr:    .asciiz  "You entered the string: "
            .align 2   # align users input on a word boundary
varStr:     .space 32  # will hold the user's input string thestring of 20 bytes 
                       # last two chars are \n\0  (a new line and null char)
                       # If user enters 31 characters then clicks "enter" or hits the
                       # enter key, the \n will not be inserted into the 21st element
                       # (the actual users character is placed in 31st element).  the 
                       # 32nd element will hold the \0 character.
                       # .byte 32 will also work instead of .space 32
            .align 2   # align next prompt on word boundary
outpStrRev: .asciiz   "Your string in reverse case is: "
            .align 2   # align the output on word boundary
varStrRev:  .space 32  # reserve 32 characters for the reverse case string
	    .align 2   # align  on a word boundary
outpStrMin: .asciiz    "The min ASCII character after reversal is: "
#
            .text      # code section begins
            .globl	main 
main:  
#
# system call to display the author of this code
#
	 la $a0,outpAuth	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

#
# system call to prompt user for input
#
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
#
# system call to store user input into string thestring
#
	li $v0,8		# system call 8 for read string needs its call number 8 in $v0
        			# get return values
	la $a0,varStr    	# put the address of thestring buffer in $t0
	li $a1,32 	        # maximum length of string to load, null char always at end
				# but note, the \n is also included providing total len < 22
        syscall
        #move $t0,$v0		# save string to address in $t0; i.e. into "thestring"
#
# system call to display "You entered the string: "
#
	 la $a0,outpStr 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	
#
# system call to display user input that is saved in "varStr" buffer
#
	 la $a0,varStr  	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
#
# Your code to invoke revCase goes next	 
#
	la $a0, varStr # stores base address of the character array in $a0
	
	# Calculate the length of the input string (excluding newline and null char)
		la $t0, varStr
		li $t1, -1
	strLen:
		lb $t2, 0($t0)
		beq $t2, 0, endStrLen
		addi $t0, $t0, 1
		addi $t1, $t1, 1
		j strLen
	endStrLen:
		move $a1, $t1
	
	jal revCase

# Exit gracefully from main()
         li   $v0, 10       # system call for exit
         syscall            # close file
         
             
################################################################
# revCase() procedure can go next
################################################################
#  Write code to reverse the case of the string.  The base address of the
# string should be in $a0 and placed there by main().  main() should also place into
# $a1 the number of characters in the string.
#  You will want to have a label that main() will use in its jal 
# instruction to invoke revCase, perhaps revCase:
#
revCase:

    la $t1, varStrRev    # Load the base address of the reversed string in $t1
	li $t4, -2 			# track the loop number in $t4 ( adjusted to -2 to account for \n and \0)
    # Loop through each character of the string
    loopRev:
        beq $t4, $a1, endRevLoop  # If every string char checked, exit the loop
    	    addi $t4, $t4, 1 # Increment loop tracking number
        lb $t2, 0($a0)    # Load a character from the original string

        # Check if the character is uppercase
        blt $t2, 'a', checkLower
        bgt $t2, 'z', checkLower

        # Convert uppercase to lowercase by adding the ASCII difference
        li $t3, 32   # ASCII difference between 'A' and 'a'
        sub $t2, $t2, $t3
        b storeCharRevCase

    checkLower:
        # Check if the character is lowercase
        blt $t2, 'A', storeCharRevCase
        bgt $t2, 'Z', storeCharRevCase

        # Convert lowercase to uppercase by adding the ASCII difference
        li $t3, 32   # ASCII difference between 'a' and 'A'
        add $t2, $t2, $t3

    storeCharRevCase:
        sb $t2, 0($t1)    # Store the reversed character in the new string
        addi $a0, $a0, 1  # Move to the next character in the original string
        addi $t1, $t1, 1  # Move to the next character in the reversed string
        j loopRev

    endRevLoop:
    
#
# After reversing the string, you may print it with the following code.
# This is the system call to display "Your string in reverse case is: "
	 la $a0,outpStrRev 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	
# system call to display the user input that is in reverse case saved in the varRevStr buffer
	 la $a0,varStrRev  	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

#
# Your code to invoke findMin() can go next
    addi $sp, $sp, -4 # Adjust the stack pointer
    sw $ra, 0($sp)  # Save $ra on the stack
    
	la $a0, varStrRev  # stores base address of the reverse case character array in $a0
	jal findMin

# Your code to return to the caller main() can go next
	lw $ra, 0($sp)  # Load $ra from the stack
	addi $sp, $sp, 4 # Adjust the stack pointer
    
	jr $ra


################################################################
# findMin() function can go next
################################################################
#  Write code to find the minimum character in the string.  The base address of the
# string should be in $a0 and placed there by revCase.  revCase() should also place into
# $a1 the number of characters in the string.
#  You will want to have a label that revCase() will use in its jal 
# instruction to invoke revCase, perhaps findMin:
#
# 
findMin:
# write use a loop and find the minimum character

    li $t2, 127          # Initialize $t2 with the maximum possible ASCII value
    li $t3, 0 			# track the loop number (disregarding /n and /0)
    # Loop through each character of the reversed case string
    findMinLoop:
    		beq $t3, $a1, endFindMin  # If every string char checked, exit the loop
    		addi $t3, $t3, 1		# Increment loop tracking number
        lb $t1, 0($a0)    # Load a character from the reversed case string
        
        # Check if the current character is smaller than the current minimum
        blt $t1, $t2, updateAndContinueMin

    continueMin:
        addi $a0, $a0, 1  # Move to the next character in the reversed case string
        j findMinLoop
        
    updateAndContinueMin:
        move $t2, $t1     # Update the minimum character
        addi $a0, $a0, 1  # Move to the next character in the reversed case string
        j findMinLoop

    endFindMin:

#
# system call to display "The min ASCII character after reversal is:  "
	 la $a0,outpStrMin 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	

# write code for the system call to print the the minimum character
	move $a0, $t2         # Load the minimum character in $a0
    li $v0, 11            # System call code for printing a character
    syscall

# write code to return to the caller revCase() can go next
	jr $ra
