.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0 # result           
    li t1, 0 # counter
    li t3, 1 # end addition threshold

loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation
    # load the two inputs
    lw t2, 0(a0)
    lw t4, 0(a1)

loop:
    # addition
    add t0, t0, t2
    # loop for number of the element in second array times
    addi t4, t4, -1
    # continue addition
    bge t4, t3, loop

next_element:
    # move to next element
    mv t5, a3 # stride for first array
stride_1st_array:
    addi a0, a0, 4
    addi t5, t5, -1
    bnez t5, stride_1st_array
    mv t6, a4 # stride for second array
stride_2nd_array:
    addi a1, a1, 4
    addi t6, t6, -1
    bnez t6, stride_2nd_array
    # increase the counter
    addi t1, t1, 1
    # loop continue
    j loop_start

loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit
