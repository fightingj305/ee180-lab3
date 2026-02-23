###############################################################################
# File         : ll_sc.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'll' and 'sc' instructions.
#
###############################################################################


    .section .boot, "x"
    .balign 4
    .set    noreorder
    .global boot
    .ent    boot
boot:
    lui     $s0, 0x8002         # Base address of status/test registers
    ori     $s1, $0, 1          # Prepare the 'done' status
    ori     $v0, $0, 1          # pass by default

    lui     $t0, 0x0000
    ori     $t0, $t0, 3210      # Load some valid address 0x00003210 to register $t0

    lui     $t1, 0xdead
    ori     $t1, $t1, 0xbeef    
    sw      $t1, 0($t0)         # store 0xdeadbeef at t0

    ll      $t2, 0($t0)         # $t2 = 0xdeadbeef
    lui     $t3, 0x1234
    ori     $t3, $t3, 0x5678    # store t3 = 0x12345678
    sc      $t3, 0($t0)         

    subu    $t4, $t3, $s1       # $t4 = 0 if $t3 == 1
    bne     $t4, $0, fail       # fail if SC did not return 1
    nop

    lw      $t5, 0($t0)         # Verify memory was updated
    lui     $t6, 0x1234
    ori     $t6, $t6, 0x5678
    subu    $t4, $t5, $t6       # $t4 = 0 if memory holds 0x12345678
    bne     $t4, $0, fail 
    nop
    

    ll      $t2, 4($t0)         
    sw      $t1, 4($t0)         # break the link
    sc      $t3, 4($t0)        

    bne     $t3, $0, fail       # fail if SC returned 1
    nop
    j       finish
    nop

fail:
    ori     $v0, $0, 0          # Failure: return 0

finish:
    sw      $v0, 4($s0)         # Set the test result (1 = pass, 0 = fail)
    sw      $s1, 0($s0)        # Set 'done'

$done:
    j       $done

    .end boot
