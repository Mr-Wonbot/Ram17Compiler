	.text
	.globl main
main:
	#begin prologue -- main
	subu $sp, $sp, 24    # stack frame is at least 24 bytes
	sw $fp, 4($sp)       # save caller's frame pointer
	sw $ra, 0($sp)       # save return address
	addi $fp, $sp, 20    # set up main's frame pointer
	#end prologue -- main
	#start And
	li $v0, 0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 0
	lw $t1 0($sp)
	addu $sp, $sp, 4
	and $v0, $t1, $v0
	#end And
	beqz $v0, ifFalse2
	#begin Println
	li $v0, 0        # load literal 0 into $v0
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
	j isDone2
ifFalse2:
	#start And
	li $v0, 0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 1
	lw $t1 0($sp)
	addu $sp, $sp, 4
	and $v0, $t1, $v0
	#end And
	beqz $v0, ifFalse3
	#begin Println
	li $v0, 1        # load literal 1 into $v0
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
	j isDone3
ifFalse3:
	#start And
	li $v0, 1
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 0
	lw $t1 0($sp)
	addu $sp, $sp, 4
	and $v0, $t1, $v0
	#end And
	beqz $v0, ifFalse4
	#begin Println
	li $v0, 2        # load literal 2 into $v0
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
	j isDone4
ifFalse4:
	#begin Println
	li $v0, 3        # load literal 3 into $v0
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
isDone4:
isDone3:
isDone2:
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


