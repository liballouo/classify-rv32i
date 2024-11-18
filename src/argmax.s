.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lw t0, 0(a0)

    li t1, 0 # index 
    li t2, 1 # length counter
loop_start:
    # TODO: Add your own implementation
    # initialize the maximum number
    li t3, 0 # tmp max
    # initialize the result (the index of the first maximum element)
    li t4, 0 # tmp index
loop:
    # loop done
    blt a1, t2, done
    # load next element
    lw t0, 0(a0)
    # if current number is less than maximum number, move to next number 
    blt t0, t3, skip
    # update the maximum value
    mv t3, t0
    # update the result index
    mv t4, t1

skip:
    # move to the next element
    addi a0, a0, 4
    # increase the index
    addi t1, t1, 1
    # increase the length counter
    addi t2, t2, 1
    # loop continue
    j loop

done:
    # store the result
    mv a0, t4
    jr ra

handle_error:
    li a0, 36
    j exit
