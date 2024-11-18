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

loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation
    # load the two inputs
    lw t2, 0(a0)
    lw t4, 0(a1)

    # initialize the number of elements
    li t5, 0
mul_start:
    # finish mul
    beq t4, x0, mul_done
    # decide whether adding multiplier to the result or not
    andi t3, t4, 1
    # skip addition if LSB of multiplicand is 0
    beq t3, x0, skip_add
    # add multiplier to the result
    add t0, t0, t2
skip_add:
    # shift multiplier and multiplicand
    slli t2, t2, 1
    srli t4, t4, 1
    # continue mul if multiplicand still has value
    bne t4, x0, mul_start
mul_done:
    # increase counter
    addi t1, t1, 1
    # get the strides of two arrays
    slli t5, a3, 2
    slli t6, a4, 2
    # get the next address by adding differences
    add a0, a0, t5
    add a1, a1, t6

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
