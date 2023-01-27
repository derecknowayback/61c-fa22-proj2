.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
    # Prologue
    addi t0, x0, 1 # t0 = 1
    blt a1, t0, exceptions # if a1 < 1 then exceptions
    add t3, x0, x0 
    lw t1, 0(a0)
    beq t0, a1, loop_end 
loop_start:
    slli t2, t0, 2
    add t2, a0, t2
    lw t2, 0(t2)
    bge t1, t2, loop_continue
    add t1, t2, x0
    add t3, x0, t0
loop_continue:
    addi t0, t0, 1
    blt t0, a1, loop_start
loop_end:
    # Epilogue
    add a0, t3, x0
    jr ra
exceptions:
    li a0,36  
    j exit