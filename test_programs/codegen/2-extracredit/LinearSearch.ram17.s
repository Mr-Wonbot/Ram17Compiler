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
	li $v0, 10        # load literal 10 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	jal Start
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
Start:
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
	#start Call
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	jal Init
	addi $sp, $sp, 4
	#end Call
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	#start Call
	jal Print
	addi $sp, $sp, 4
	#end Call
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	#begin Println
	li $v0, 9999        # load literal 9999 into $v0
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
	#begin Println
	#start Call
	li $v0, 8        # load literal 8 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	jal Search
	addi $sp, $sp, 4
	#end Call
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
	#begin Println
	#start Call
	li $v0, 12        # load literal 12 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	jal Search
	addi $sp, $sp, 4
	#end Call
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
	#begin Println
	#start Call
	li $v0, 17        # load literal 17 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	jal Search
	addi $sp, $sp, 4
	#end Call
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
	#begin Println
	#start Call
	li $v0, 50        # load literal 50 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	jal Search
	addi $sp, $sp, 4
	#end Call
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	#end Println
	li $v0, 55        # load literal 55 into $v0
	lw $ra, -12($fp)
	lw $fp, -4($fp)
	addi $sp, $sp, 16
	jr $ra
Print:
	subu $sp, $sp, 16
	sw $fp, 8($sp)
	sw $ra, 0($sp)
	addu $fp, $sp, 12
	#start Indentifier
	#end Indentifier
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	li $v0, 1        # load literal 1 into $v0
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
	lw $t1 0($sp)
	addu $sp, $sp, 4
	slt $v0, $t1, $v0
	#end LessThan
	subu $sp, $sp, 4
	sw $v0 0($sp)
	beqz $v0, ifFalse16
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
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	li $v0, 1        # load literal 1 into $v0
jr $v016:
ifFalse16:
isDone16:
	li $v0, 0        # load literal 0 into $v0
	lw $ra, -12($fp)
	lw $fp, -4($fp)
	addi $sp, $sp, 16
	jr $ra
Search:
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
	li $v0, 1        # load literal 1 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	li $v0, 0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	li $v0, 0        # load literal 0 into $v0
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
	lw $t1 0($sp)
	addu $sp, $sp, 4
	slt $v0, $t1, $v0
	#end LessThan
	subu $sp, $sp, 4
	sw $v0 0($sp)
	beqz $v0, ifFalse17
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
	#start LessThan
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	addi $v0, $fp, -1
	lw $v0, ($v0)
	lw $t1 0($sp)
	addu $sp, $sp, 4
	slt $v0, $t1, $v0
	#end LessThan
	beqz $v0, ifFalse18
	li $v0, 0        # load literal 0 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	j isDone18
ifFalse18:
	#start Not
	#start LessThan
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	addi $v0, $fp, -1
	lw $v0, ($v0)
	lw $t1 0($sp)
	addu $sp, $sp, 4
	slt $v0, $t1, $v0
	#end LessThan
	xori $v0, $v0, 1
	#end Not
	beqz $v0, ifFalse19
	li $v0, 0        # load literal 0 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	j isDone19
ifFalse19:
	li $v0, 1
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
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
isDone19:
isDone18:
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
jr $v017:
ifFalse17:
isDone17:
	addi $v0, $fp, -1
	lw $v0, ($v0)
	lw $ra, -12($fp)
	lw $fp, -4($fp)
	addi $sp, $sp, 16
	jr $ra
Init:
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
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	li $v0, 1        # load literal 1 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	#begin Plus
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
	#start LessThan
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	lw $t1 0($sp)
	addu $sp, $sp, 4
	slt $v0, $t1, $v0
	#end LessThan
	subu $sp, $sp, 4
	sw $v0 0($sp)
	beqz $v0, ifFalse20
	#begin Times
	li $v0, 2        # load literal 2 into $v0
	subu $sp, $sp, 4
	sw $v0 0($sp)
	addi $v0, $fp, -1
	lw $v0, ($v0)
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
	#begin Minus
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 3        # load literal 3 into $v0
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sub $v0, $t1, $v0
	#end Minus
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
	#start Indentifier
	#end Indentifier
	addi $v0, $fp, -1
	lw $v0, ($v0)
	#begin Plus
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	addi $v0, $fp, -1
	lw $v0, ($v0)
	lw $t1, 0($sp)
	addu $sp, $sp, 4
	add $v0, $t1, $v0
	#end Plus
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	li $v0, 1        # load literal 1 into $v0
	#begin Minus
	addi $v0, $fp, -1
	lw $v0, ($v0)
	subu $sp, $sp, 4
	sw $v0 0($sp)
	li $v0, 1        # load literal 1 into $v0
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sub $v0, $t1, $v0
	#end Minus
	subu $sp, $sp, 4
	sw $v0 0($sp)
	#start Indentifier
	addi $v0, $fp, -1
	#end Indentifier
	lw $t1 0($sp)
	addu $sp, $sp, 4
	sw $t1, $v0
jr $v020:
ifFalse20:
isDone20:
	li $v0, 0        # load literal 0 into $v0
	lw $ra, -12($fp)
	lw $fp, -4($fp)
	addi $sp, $sp, 16
	jr $ra
	
	.data
newline: .asciiz "\n"
space: .asciiz " "


