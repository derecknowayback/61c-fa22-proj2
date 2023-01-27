.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Prologue
    addi t0, x0, 1 # t0 = 1
    blt a1, t0, exceptions # if a1 <1 then target
    add t0, x0, x0
loop_start:
    slli t3, t0, 2 
    add t1, t3, a0
    lw  t2,0(t1)
    bgt t2, x0, loop_continue
    add t2, x0, x0
    sw t2, 0(t1) # 
loop_continue:
    addi t0,t0,1
    blt t0,a1,loop_start
loop_end:

    # Epilogue
    jr ra
exceptions:
    li a0,36  
    j exit