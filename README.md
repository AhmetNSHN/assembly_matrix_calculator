# Assembly Matrix Calculator

This project is an assembly language program designed to perform matrix calculations. Comments added to the code file for more technical and detailed explanation. Role of each register and purpose of each line added.

## Overview

The program is structured into several procedures, each handling a specific part of the matrix calculation process:

### Main Procedure

- **Lines 4-7**: Set the row and column numbers of matrices in registers.
- **Line 9**: Checks if matrices are suitable for multiplication. If not, it jumps to the `error` procedure to terminate the program.
- **Lines 9-20**: Initialize counters used in the `matrix_multiply` procedure.
  - `$s0`: Shifts the address of operand to the next row of M1.
  - `$s7`: Shifts the address of operand to the next row of M2.
  - `$s5`: Stores the data size of the result matrix.
  - Counters: `$t0`, `$t5`, `$t6`, `$t7`, `$t8`.

### Matrix Multiply Procedure

This procedure is used to find the transpose of matrix M2, referred to as `M2_transpose`.
- **Counter `$t0`**: Increased by the size of the column number multiplied by 4 to access the entire column of M1.
- **Counter `$t8`**: Increased by 4 to move to the next address in `M2_transpose`.
- **Operations**: The column of M1 is placed into the row of `M2_tr`. The `change_column` procedure is then used to transpose other columns of M2 into `M2_tr`, ensuring that the rows of the original M2 matrix are converted to columns in `M2_tr`.
- **Termination**: The procedure ends by jumping to the `inner_product_counter_initializer` procedure.

### Inner Product Counter Initializer Procedure

Initializes registers used in the `inner_product` procedure:
- `$t5`: Holds the multiplication result.
- `$t7`: All `$t5` results are added in this register, which holds the result to print out.

### Inner Product Method

Calculates the multiplication results of matrices. This method utilizes the transposed matrix `M2_tr` to compute the inner products between M1 and `M2_tr`.

### Print Index Procedure

- **Function**: Prints acquired results.
- **Termination**: Terminates the program if all results are printed. Uses the `change_row` procedure to print the result in the next line.
