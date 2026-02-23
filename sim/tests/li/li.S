###############################################################################
# File         : lui.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'lui' instruction.
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
    
    li      $t0, 0x89ABCDEF
    lui     $t1, 0x89AB
    ori     $t1, $t1, 0xCDEF
    subu    $t2, $t0, $t1
    sltiu   $v0, $t2, 1

    sw      $v0, 4($s0)
    sw      $s1, 0($s0)

$done:
    j       $done
    nop

    .end boot
