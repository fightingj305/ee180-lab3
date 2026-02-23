################################################################################
# File         : jal.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'jal' instruction.
#
###############################################################################


    .section .boot, "x"
    .balign 4
    .set    noreorder
    .global boot
    .ent    boot
    
boot:
    lui     $s0, 0x8002
    ori     $s1, $0, 1
    jal     target
    ori     $t3, $0, 0

after:
    la      $t0, after
    subu    $t1, $ra, $t0
    sltiu   $t2, $t1, 1
    and     $v0, $t2, $t3

finish:
    sw      $v0, 4($s0)
    sw      $s1, 0($s0)
    
done:
    j       done
    nop

target:
    ori     $t3, $0, 1
    jr      $ra
    nop

    .end boot