################################################################################
# File         : jalr.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'jalr' instruction.
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
    la      $t0, target
    jalr    $ra, $t0
    ori     $t3, $0, 0

after_jalr:
    la      $t1, after_jalr
    subu    $t2, $ra, $t1
    sltiu   $t4, $t2, 1
    and     $v0, $t4, $t3
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
