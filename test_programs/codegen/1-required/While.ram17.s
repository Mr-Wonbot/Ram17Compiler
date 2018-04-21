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
	li $v0, 8        # load literal 8 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 7        # load literal 7 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 6        # load literal 6 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 5        # load literal 5 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 4        # load literal 4 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 3        # load literal 3 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	jal method
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
method:
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
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	#start LessThan
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 20        # load literal 20 into $v0
	lw $t1 0($sp)
	addu $sp, $sp, 4
	slt $v0, $t1, $v0
	#end LessThan
	subu $sp, $sp, 4
	sw $v0 0($sp)
	beqz $v0, ifFalse15
	#begin Println
	addi $v0, $fp, -1
	lw $v0, ($v0)
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
	#begin Plus
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 1        # load literal 1 into $v0
	lw $t1, 0($sp)
	addu $sp, $sp, 4
	add $v0, $t1, $v0
	#end Plus
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
jr $v015:
ifFalse15:
isDone15:
	addi $v0, $fp, -1
	lw $v0, ($v0)
	lw $ra, -12($fp)
	lw $fp, -4($fp)
	addi $sp, $sp, 16
	jr $ra
	
	.data
newline: .asciiz "\n"
space: .asciiz " "


