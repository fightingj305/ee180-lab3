###############################################################################
# File         : sltu.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'sltu' (register) instruction.
#
###############################################################################

    .section .boot, "x"
    .balign 4
    .set    noreorder
    .global boot
    .ent    boot
boot:
    lui     $s0, 0x8002         # base address of status/test regs
    ori     $s1, $zero, 1       # done = 1
    nop

    ori     $t2, $zero, 1
    ori     $t1, $zero, 2
    sltu    $t0, $t2, $t1       # expect 1
    nop
    nop

    sw      $t0, 4($s0)         # write test result (should be 1)
    sw      $s1, 0($s0)         # done

done:
    j       done
    nop
    .end boot
