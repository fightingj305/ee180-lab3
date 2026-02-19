###############################################################################
# File         : nor.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'nor' instruction. Compute NOR of two
#   registers and compare against the expected constant.
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

    # Set inputs: $t0 = 0x000000FF, $t1 = 0x0000FF00
    ori     $t0, $zero, 0x00FF
    ori     $t1, $zero, 0xFF00

    nor     $t2, $t0, $t1       # t2 = ~(t0 | t1) = 0xFFFF0000

    # expected = 0xFFFF0000
    lui     $t3, 0xFFFF

    subu    $t4, $t2, $t3       # t4 == 0 if equal
    sltiu   $v0, $t4, 1         # v0 = 1 if equal, else 0

    sw      $v0, 4($s0)         # Set the test result
    sw      $s1, 0($s0)         # Set 'done'

$done:
    j       $done
    nop

    .end boot
