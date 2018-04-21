	.text
	.globl main
main:
	#begin prologue -- main
	subu $sp, $sp, 24    # stack frame is at least 24 bytes
	sw $fp, 4($sp)       # save caller's frame pointer
	sw $ra, 0($sp)       # save return address
	addi $fp, $sp, 20    # set up main's frame pointer
	#end prologue -- main
	#start Not
	li $v0, 1
	xori $v0, $v0, 1
	#end Not
	beqz $v0, ifFalse8
	#begin Println
	li $v0, 0        # load literal 0 into $v0
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
	j isDone8
ifFalse8:
	#start Not
	li $v0, 0
	xori $v0, $v0, 1
	#end Not
	beqz $v0, ifFalse9
	#begin Println
	li $v0, 1        # load literal 1 into $v0
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
	j isDone9
ifFalse9:
	#begin Println
	li $v0, 2        # load literal 2 into $v0
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
isDone9:
isDone8:
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


