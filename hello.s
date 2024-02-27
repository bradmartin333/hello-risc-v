    .globl  _start

_start:
    li      s0, 10        # set iterator max for y
    li      s1, 10        # set iterator max for x
    li      s2, 0         # outer iterator
    li      s4, 8         # num to shift for RGB channels
    li      s5, 0xFF      # value to use for RGB channels
    li      s6, 3         # modulo value for determining RGB

outer:
    li      s7, 0         # inner iterator
inner:
    li      a0, 1         # going to print the modulo
    rem     a1, s7, s6    # calc modulo for printing
    addi    t0, a1, 0     # store the modulo for later
    ecall                 # print

    li      a0, 4         # going to print ascii newline
    la      a1, newline   # load ascii
    ecall                 # print

    li      a0, 0x100     # going to update led matrix
    mul     t1, t0, s4    # determine RGB channel offset
    sll     a2, s5, t1    # set LED matrix color with offset
    li      a1, 0         # reset selected LED register
    slli    a1, s2, 16    # shift by inner iterator
    or      a1, a1, s7    # combine shifter inner iterator and outer
    ecall                 # set LED

    addi    s7, s7, 1     # increment inner loop iterator
    bne     s7, s0, inner # check if inner loop finished
    addi    s2, s2, 1     # increment outer loop iterator
    bne     s2, s1, outer # check if outer loop finished
    jal     end

end:
    li      a0, 10        # exit code
    li      a7, 93        # syscall exit
    ecall

    .data
newline:
    .asciiz "\n"
