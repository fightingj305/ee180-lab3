###############################################################################
# File         : or.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'or' instruction.
#
###############################################################################

    .section .boot, "x"
    .balign 4
    .set    noreorder
    .global boot
    .ent    boot
boot:
    lui     $s0, 0x8002         # Load the base address of the status/test registers
    ori     $s1, $0, 1          # Prepare the 'done' status

    # Prepare operands: $t0 = 0x00FF, $t1 = 0xFF00
    ori     $t0, $zero, 0x00FF
    ori     $t1, $zero, 0xFF00

    or      $t2, $t0, $t1       # t2 = t0 | t1 = 0x0000FFFF

    # expected = 0x0000FFFF
    ori     $t3, $zero, 0xFFFF

    subu    $t4, $t2, $t3       # t4 == 0 if equal
    sltiu   $v0, $t4, 1         # v0 = 1 if equal, else 0

    sw      $v0, 4($s0)         # Set the test result
    sw      $s1, 0($s0)         # Set 'done'

$done:
    j       $done
    nop

    .end boot
