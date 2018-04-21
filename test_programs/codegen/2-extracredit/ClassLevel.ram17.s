	.text
	.globl main
main:
	#begin prologue -- main
	subu $sp, $sp, 24    # stack frame is at least 24 bytes
	sw $fp, 4($sp)       # save caller's frame pointer
	sw $ra, 0($sp)       # save return address
	addi $fp, $sp, 20    # set up main's frame pointer
	#end prologue -- main
	#begin Println
	#start Call
	li $v0, 4        # load literal 4 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	jal helper
	addi $sp, $sp, 4
	#end Call
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
	#begin epilogue -- main
	lw $ra, 0($sp)       # restore return address
	lw $fp, 4($sp)       # restore caller's frame pointer
	addi $sp, $sp, 24    # pop the stack
	#end epilogue -- main
	li $v0, 10
	syscall
	#start Indentifier
	#end Indentifier
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
helper:
	subu $sp, $sp, 16
	sw $fp, 8($sp)
	sw $ra, 0($sp)
	addu $fp, $sp, 12
	#start Indentifier
	#end Indentifier
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	li $v0, 5        # load literal 5 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	#begin Times
	li $v0, 4        # load literal 4 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	lw $t1 0($sp)
	addu $sp, $sp, 4
	mul $v0, $t1, $v0
	#end Times
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	li $v0, 1        # load literal 1 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	#begin Minus
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sub $v0, $t1, $v0
	#end Minus
	lw $ra, -12($fp)
	lw $fp, -4($fp)
	addi $sp, $sp, 16
	jr $ra
	
	.data
newline: .asciiz "\n"
space: .asciiz " "


