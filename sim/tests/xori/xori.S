###############################################################################
# File         : xori.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'xori' instruction.
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
    lui     $t0, 0xdeaf         # A = 0xdeafbeef
    ori     $t0, $t0, 0xbeef
    xori    $t3, $t0, 0x1111    # D = xor(0xdeafbeef, 0x1111) = 0xdeafbefe
    lui     $t2, 0xdeaf         # expected = 0xdeafbefe
    ori     $t2, $t2, 0xbefe
    subu    $t4, $t2, $t3       # check if equal (should be 0)
    sltiu   $v0, $t4, 1         # v0 = 1 if equal
    sw      $v0, 4($s0)         # Set the test result
    sw      $s1, 0($s0)         # Set 'done'

$done:
    j       $done
    nop

    .end boot
