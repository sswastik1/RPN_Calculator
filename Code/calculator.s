#
# CMPUT 229 Student Submission License
# Version 1.0
#
# Copyright 2019 <student name>
#
# Redistribution is forbidden in all circumstances. Use of this
# software without explicit authorization from the author or CMPUT 229
# Teaching Staff is prohibited.
#
# This software was produced as a solution for an assignment in the course
# CMPUT 229 - Computer Organization and Architecture I at the University of
# Alberta, Canada. This solution is confidential and remains confidential 
# after it is submitted for grading.
#
# Copying any part of this solution without including this copyright notice
# is illegal.
#
# If any portion of this software is included in a solution submitted for
# grading at an educational institution, the submitter will be subject to
# the sanctions for plagiarism at that institution.
#
# If this software is found in any public website or public repository, the
# person finding it is kindly requested to immediately report, including 
# the URL or other repository locating information, to the following email
# address:
#
#          cmput229@ualberta.ca
#
#---------------------------------------------------------------
# CCID:                 swastik 
# Lecture Section:      A1
# Instructor:           J. Nelson Amaral
# Lab Section:          D03
# Teaching Assistant:   Islam Ali, Siva Chowdeswar Nandipati
#---------------------------------------------------------------
# 
.include "common.s"
#----------------------------------

#--------------------------------------------------------------
# calculator
# This is the main function executing the whole program. Matches the token
# value with the required and then decides and executes the connected funct.
#
# Register Usage:
# a0: address of the memory where the list of tokens is stored
# t0: stores the value stored at a0
# t1: immediate  storage of constant -1
# t2: immediate  storage of constant -2
# t3: immediate  storage of constant -3
# a7: used for initializing sysCalls
#
#---------------------------------------------------------------
calculator:
	lw t0, 0(a0) 
	bge t0, zero, stacking 					#initiating stacking
	li t1, -1
	beq t0, t1, plus 						#initiating addition
	li t2, -2
	beq t0, t2, minus 						#initiating addition
	li t3, -3
	bne t0, t3, calculator 					# maintaining the loop
											# if nothing happens
	
	li a7, 1								# for executing PrintInt
	lw a0, 0(a1)
	ecall
	li a7, 10								# for executing Quit
	ecall
	jr ra

#---------------------------------------------------------------
# stacking
# It stacks the required value from the array memory to the topmost stack.
#
# Register Usage:
# t0: storing the value at the memory address of a1
# a0: address of the memory where the list of tokens is stored
# a1: address of the memory that is to be used as a stack
#---------------------------------------------------------------	
stacking:
	sw t0, 0(a1)  
	addi a0, a0, 4 							# changing the value of a7
	addi a1, a1, -4 						# changing the value of a1
	jal calculator

#---------------------------------------------------------------
# plus
# It pops the topmost elements of stack and then adds them and 
# stores the added result at top of the stack
# 
# Register Usage:
# t2: storing the value at the memory address 4 bits more than a1
# t3: storing the value at the memory address 8 bits more than a1
# t4: result of addition
# a0: address of the memory where the list of tokens is stored
# a1: address of the memory that is to be used as a stack
#---------------------------------------------------------------		
plus:
	lw t2, 4(a1) 
	lw t3, 8(a1) 

	add t4, t3, t2
	addi a1, a1, 8
	sw t4, 0(a1) 							# storing result
	addi a0, a0, 4
	

	jal calculator
	
#---------------------------------------------------------------
# minus
# It pops the topmost elements of stack and then subtracts them and 
# stores the subtracted result at top of the stack
# 
# Register Usage:
# t2: storing the value at the memory address 4 bits more than a1
# t3: storing the value at the memory address 8 bits more than a1
# t4: result of addition
# a0: address of the memory where the list of tokens is stored
# a1: address of the memory that is to be used as a stack
#---------------------------------------------------------------	
minus:
	lw t2, 4(a1) 
	lw t3, 8(a1) 

	sub t4, t3, t2
	addi a1, a1, 8
	sw t4, 0(a1) 							# storing result
	addi a0, a0, 4
	

	jal calculator

#-----------------------------------------	