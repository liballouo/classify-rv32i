.globl relu

.text
# ==============================================================================
# FUNCTION: Array ReLU Activation
#
# Applies ReLU (Rectified Linear Unit) operation in-place:
# For each element x in array: x = max(0, x)
#
# Arguments:
#   a0: Pointer to integer array to be modified
#   a1: Number of elements in array
#
# Returns:
#   None - Original array is modified directly
#
# Validation:
#   Requires non-empty array (length ≥ 1)
#   Terminates (code 36) if validation fails
#
# Example:
#   Input:  [-2, 0, 3, -1, 5]
#   Result: [ 0, 0, 3,  0, 5]
# ==============================================================================
relu:
    li t0, 1             
    blt a1, t0, error     
    li t1, 0 # length counter           

loop_start:
    # TODO: Add your own implementation
    bge t1, a1, done
    # load the input integer
    lw t2, 0(a0)
    # if the input integer is negative, then set to 0
    bltz t2, negative
    # move to next element
    j next_element

negative:
    # modify the integer to zero
    sw x0, 0(a0)

next_element:
    # move to the next element in the array
    addi a0, a0, 4
    # increase the length counter
    addi t1, t1, 1
    # countinue loop
    j loop_start

done:
    jr ra

error:
    li a0, 36          
    j exit          
