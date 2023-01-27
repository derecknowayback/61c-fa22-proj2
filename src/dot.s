.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:

    # Prologue
    addi t0, x0, 1 # t0 = 1
    blt a2, t0, exceptions1 # if a1 <1 then target
    blt a3, t0, exceptions2
    blt a4, t0, exceptions2
    add t0, x0, x0
    add t1, x0, x0
    add t3, a0, x0
    add t4, a1, x0
loop_start:
    lw a0, 0(t3) #
    add t2, x0, a0
    bge t2, x0, abs1_end
    sub t2, x0, t2
    
    abs1_end:
    lw a1, 0(t4)
    add t5, x0, a1
    bge t5, x0, abs2_end
    sub t5, x0, t5

    abs2_end:
    beq t2, x0, loop_continue
    beq t5, x0, loop_continue
    add t6, x0, x0
    multiply_start:
        add t6, t6, t5
        addi t2, t2, -1
        bne t2, x0, multiply_start
    srli a0, a0, 31
    srli a1, a1, 31
    xor a0, a0, a1
    beq a0, x0, loop_continue
    sub t6, x0, t6

loop_continue:
    add t1, t1, t6
    addi t0, t0, 1

    add t2, a3, x0
    stride2:
        addi t3, t3, 4
        addi t2, t2, -1
        bne t2, x0,stride2
    
    add t2, a4, x0
    stride3:
        addi t4, t4, 4
        addi t2, t2, -1
        bne t2, x0,stride3
    blt t0, a2, loop_start
loop_end:
    # Epilogue
    add a0, t1, x0
    jr ra
exceptions1:
    li a0,36  
    j exit
exceptions2:
    li a0,37  
    j exit    