	.text
	.globl main
main:
	#begin prologue -- main
	subu $sp, $sp, 24    # stack frame is at least 24 bytes
	sw $fp, 4($sp)       # save caller's frame pointer
	sw $ra, 0($sp)       # save return address
	addi $fp, $sp, 20    # set up main's frame pointer
	#end prologue -- main
	#begin Print
	#begin Minus
	#begin Plus
	li $v0, 5        # load literal 5 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#begin Times
	li $v0, 3        # load literal 3 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 2        # load literal 2 into $v0
	lw $t1 0($sp)
	addu $sp, $sp, 4
	mul $v0, $t1, $v0
	#end Times
	lw $t1, 0($sp)
	addu $sp, $sp, 4
	add $v0, $t1, $v0
	#end Plus
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 4        # load literal 4 into $v0
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sub $v0, $t1, $v0
	#end Minus
	move $a0, $v0
	li $v0, 1
	syscall
	#end Print
	#begin epilogue -- main
	lw $ra, 0($sp)       # restore return address
	lw $fp, 4($sp)       # restore caller's frame pointer
	addi $sp, $sp, 24    # pop the stack
	#end epilogue -- main
	li $v0, 10
	syscall
	
	.data
newline: .asciiz "\n"
space: .asciiz " "


