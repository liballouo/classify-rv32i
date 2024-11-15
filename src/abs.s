.globl abs

.text
# =================================================================
# FUNCTION: Absolute Value Converter
#
# Transforms any integer into its absolute (non-negative) value by
# modifying the original value through pointer dereferencing.
# For example: -5 becomes 5, while 3 remains 3.
#
# Args:
#   a0 (int *): Memory address of the integer to be converted
#
# Returns:
#   None - The operation modifies the value at the pointer address
# =================================================================
abs:
    # Prologue
    ebreak
    # Load number from memory
    lw t0 0(a0)
    bge t0, zero, done

    # TODO: Add your own implementation
    # mask for clear the sign-bit
    li t1, 0x7fffffff
    # clear the sign-bit
    and t0, t0, t1
    # 2^31 to substract the sign-bit cleared result
    li t1, 0x80000000
    # perform substraction
    sub t0, t1, t0

    # store the result
    sw t0 0(a0)

done:
    # Epilogue
    jr ra
