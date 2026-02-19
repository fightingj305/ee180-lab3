###############################################################################
# File         : movz.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'movz' instruction.
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
    lui     $t0, 0xdeaf
    nop
    ori     $t0, $t0, 0xbeef
    ori     $t1, $0, 0
    movz    $t2, $t0, $s1       # $t2 should remain 0 (s1 != 0)
    movz    $t1, $t0, $0        # $t1 gets 0xdeafbeef (zero condition true)
    subu    $t3, $t1, $t0       # check t1 == t0
    nop
    sltiu   $v0, $t3, 1         # v0 = 1 if t1 == t0
    sltiu   $v1, $t2, 1         # v1 = 1 if t2 == 0
    and     $v0, $v0, $v1       # final pass if both conditions true
    nop
    sw      $v0, 4($s0)         # Set the test result
    sw      $s1, 0($s0)         # Set 'done'

$done:
    j       $done
    nop

    .end boot
