.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#   d = matmul(m0, m1)
# Arguments:
#   a0 (int*)  is the pointer to the start of m0
#   a1 (int)   is the # of rows (height) of m0
#   a2 (int)   is the # of columns (width) of m0
#   a3 (int*)  is the pointer to the start of m1
#   a4 (int)   is the # of rows (height) of m1
#   a5 (int)   is the # of columns (width) of m1
#   a6 (int*)  is the pointer to the the start of d
# Returns:
#   None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 38
# =======================================================
matmul:

    # Error checks
    addi t0, x0, 1
    blt a1, t0, exceptions # if a1 < 1 then exceptions
    blt a2, t0, exceptions # if a2 < 1 then exceptions    
    blt a4, t0, exceptions # if a4 < 1 then exceptions
    blt a5, t0, exceptions # if a5 < 1 then exceptions
    bne a2, a4, exceptions # if a2 != a4 then exceptions
    
    # Prologue
    add t0, x0, x0
outer_loop_start:
    add t2, x0, x0
inner_loop_start:
    # need 2 store: t0,t2,a6,a1,a2,a3,a4,a0,ra,a5,t2
    addi sp, sp, -40
    sw t0, 0(sp)
    sw a0, 4(sp)
    sw a1, 8(sp)
    sw a2, 12(sp)
    sw a3, 16(sp)
    sw a4, 20(sp)
    sw a6, 24(sp)
    sw ra, 28(sp)
    sw a5, 32(sp)
    sw t2, 36(sp)

    mul t1, t0, a2
    slli t1, t1, 2
    add a0, a0, t1 # addr of a[i]
    slli t1, t2, 2
    add a1, a3, t1 # addr of b[j]
    # a2 don't change
    addi a3, x0, 1 # stride of a[]
    add a4, x0, a5  # stride of b[] 

    jal ra dot

    add t1, a0, x0 # store the res 2 t1
    
    #recovery... 
    lw t0, 0(sp)
    lw a1, 8(sp)
    lw a2, 12(sp)
    lw a3, 16(sp)
    lw a4, 20(sp)
    lw a6, 24(sp)
    lw ra, 28(sp)
    lw a5, 32(sp)
    lw t2, 36(sp)

    # write 2 target
    add t1, t2, x0
    mul t3, a5, t0
    add t1, t1, t3
    slli t1, t1, 2
    add t1, a6, t1
    sw a0, 0(t1) # 
    lw a0, 4(sp)
    addi sp, sp, 40

inner_loop_end:
    addi t2, t2, 1
    blt t2, a5, inner_loop_start

outer_loop_end:
    addi t0, t0, 1
    blt t0, a1, outer_loop_start
    # Epilogue
    jr ra
exceptions:
    li a0, 38  
    j exit