# assembly_matrix_calculator
matrix calculator written with assembly language


main procedure:Line 4-7 set row and column numbers of matrices in registers
Line 9 checking if matrices are suitable for multiplication, if not jumping to procedure error to terminate program
Line 9-20 initialize counters used in matrix_multiply procedure

$s0:shifting address of operand to next row of M1
$s7:shifting address of operand to next row of M2
$S5:data size of result matrix
Counters: $t0, $t5, $t6, $t7, $t8,

************************************************************************
matrix_multiply procedure:used to find transpose of matrix M2
Counter t0 is increased by size column number x 4 to access entire column of M1

Counter t8 is increased by 4 to go next address in M2_transpose
Column of M1 is placed to row of M2_tr
Use change_column procedure to transpose other column
Procedure terminate by jumping to inner_product_counter_initializer procedure

*************************************************************************
inner_product_counter_initializer procedure: initializing registers used in inner_product procedure
t5: hold multiplication result
$t7:all $t5 result added in this register ,hold result to print out

**************************************************************************
inner_product method:calculate multiplication results

**************************************************************************
Print_index procedure:print acquired results, terminate program if all results are printed use change_row procedure to print result in next line
