.text
.globl main
main:
lw $s1, M1_r                #s1 M1 row number
lw $s2, M1_c                #s2 M1 column number
lw $s3, M2_r                #s3 M2 row number
lw $s4, M2_c                #s3 M2 column number

bne $s2, $s3, error         #check if both matrix dimensions suitable for multiplication
addi $t7, $zero, 0          #t7 1.counter
addi $t0 , $zero , 0        #t0 address counter
addi $t5 , $zero , 0        #t5 3.counter
mul $s0, $s4, 4             #s0 used to go next row in M2
mul $s7, $s2, 4             #s7 used to go next column in M1
mul $s6, $s1, $s4           #s5 data size of result matrix
mul $s5, $s6, 4             #s6 size of result matrix
addi $t8, $zero, 0          #t8 address counter 
addi $t6, $zero, 0          #t6 5.counter
subi $t4, $s4, 1          
j matrix_multiply

error:                     #if matrix sizes is not suitable
li $v0, 4
la $a0, msg1
syscall
li $v0, 10
syscall

matrix_multiply:               #find transpose of matrix
bge $t7, $s3, change_column                     #check index of row(if this counter equal to total number of colums program take other rows transpose  
lw $t1, M2($t0)
sw $t1, M2_tr($t8)                              #switch numbers between M2 and M2_transpose
add $t0, $t0, $s0              
addi $t8, $t8, 4               
addi $t7, $t7, 1
j matrix_multiply

change_column:   #it take other row to calculate its transpose
addi $t5,$t5,4                                      #t5 is to initializing $t0 in matrix_multiply
move $t0,$t5                                        #it move adress counter $t0 to next colum
bge $t8,$s5,inner_product_register_initializer       #if all matrix transposed initialize registers usedin inner_product procedure
li $t7,0                                            
j matrix_multiply

inner_product_register_initializer:
addi $t0, $zero,0                 
addi $t1, $zero,0                 #t1 counter to change M1 row: change M1 row when t1 = adress of last index in M2_tr
addi $t4, $zero,0                 #t4 counetr 2.
addi $t5, $zero,0                 #t5 multiplication result
addi $t6, $zero,0                 #t6 adress counter 1.
addi $t7, $zero,0                 #t7 sum 
addi $t8, $zero,0                 #t8 adress counter 2.
addi $t9, $zero,1                 #t9 counter for printed values: terminate program when all values printed
j inner_product               

inner_product:                    
beq $s2, $t0, print_index         #print result if counter t0 is equal to column number(all numbers in same row multiplied and added together)
lw $t3, M1($t6)                   
lw $t2, M2_tr($t8)
mul $t5, $t2, $t3                 #take numbers located in same index and multiply them
add $t7, $t7, $t5                 #add multipilied numbers with each other
addi $t6, $t6, 4                  
addi $t8, $t8, 4                  
addi $t0, $t0, 1                  #counter to determine a row is multipiled with current row of M2_tr
addi $t4, $t4, 1                  #counter to determine a row is multipiled with all rows of M2_tr
j inner_product

print_index:     #print result
li $v0, 4
la $a0 , space
syscall

li $v0,1
move $a0, $t7
syscall

addi $t7, $zero, 0
beq  $t9, $s6, exit        #terminate program if size counter is equal to size of result matrix
addi $t9, $t9, 1
beq $s6, $t4, change_row   #if row is calculated print results to next line 
add $t6, $zero, $t1        #t1 is keeping operator at the same row of M1 untill its calculated wit all rows of M2_tr(initialized in change_row)
addi $t0, $zero,0 
j inner_product 

change_row:    
li $v0, 4
la $a0 , newline
syscall

addi $t8, $zero, 0 
addi $t0, $zero,0 
addi $t4, $zero,0 
add $t1, $t1, $s7     #change m1 row
move $t6, $t1         
j inner_product

exit:   
li $v0, 10
syscall
.data
M1: .word 4,5,7,8,1,6,2,3,6
M2: .word 3,2,1,9,5,4,1,9,5,2,4,1
M2_tr: .space 48 #size of result matrix = M1_r x M2_c x 4
M1_r: .word 3
M1_c: .word 3
M2_r: .word 3
M2_c: .word 4
msg1: .asciiz "cant multiply this matrix"
space: .asciiz " "
newline: .asciiz "\n"
 
		

