###############################################################################
# File         : raw_hazard.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the RAW hazard detection logic.
#
###############################################################################

    .section .boot, "x"
    .balign 4
    .set    noreorder
    .global boot
    .ent    boot
boot:
    lui     $s0, 0x8002         # Load the base address of the status/test registers
    ori     $s1, $0, 1          # Prepare the 'done'
    lui     $t0, 0              # Load some valid address 0x00003210 to register $t0
    ori     $t0, $t0, 0x3210
    lui     $t1, 0x1
    ori     $t1, $t1, 0x1	    # $t1 = 0x00010001
    sw      $t1, 0($t0)       
    lw      $t2, 0($t0)         # RAW occurs here; should be 0x00010001
    li      $t3, 0x10000000  
    add     $t4, $t2, $t3       # RAW occurs here; should be 0x10010001
    li      $t5, 0x10010001
    subu    $t6, $t5, $t4       # should be 0
    sltiu   $v0, $t6, 1
    sw      $v0, 4($s0)         # Set the test result
    sw      $s1, 0($s0)         # Set 'done'
    .end boot
