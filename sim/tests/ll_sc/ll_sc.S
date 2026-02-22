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
    ori     $v0, $0, 1          # Assume pass; clear on any failure

    # Data address for LL/SC (use a normal RAM address)
    lui     $t0, 0x0000
    ori     $t0, $t0, 0x1000

    # --- Test 1: LL then SC with no intervening store (must succeed) ---
    lui     $t1, 0xdead
    ori     $t1, $t1, 0xbeef    # Initial value in memory
    sw      $t1, 0($t0)         # [0($t0)] = 0xdeadbeef

    ll      $t2, 0($t0)         # Load linked; $t2 = 0xdeadbeef, link set
    lui     $t3, 0x1234
    ori     $t3, $t3, 0x5678    # Value to store: 0x12345678
    sc      $t3, 0($t0)         # Store conditional; $t3 = 1 if success, 0 if fail

    subu    $t4, $t3, $s1       # $t4 = 0 if $t3 == 1 (success)
    bne     $t4, $0, fail       # Fail if SC did not return 1
    nop

    lw      $t5, 0($t0)         # Verify memory was updated
    lui     $t6, 0x1234
    ori     $t6, $t6, 0x5678
    subu    $t4, $t5, $t6       # $t4 = 0 if memory holds 0x12345678
    bne     $t4, $0, fail
    nop

    # --- Test 2: LL, then another store, then SC (must fail) ---
    ll      $t2, 4($t0)         # Load linked from 4($t0); link set
    sw      $t1, 4($t0)         # Store to 4($t0) - breaks the link
    sc      $t3, 4($t0)         # SC should fail; $t3 = 0

    bne     $t3, $0, fail       # Fail if SC returned 1 (should be 0)
    nop

    ori     $v0, $0, 1          # Success: return 1
    j       report
    nop

fail:
    ori     $v0, $0, 0          # Failure: return 0

report:
    sw      $v0, 4($s0)         # Set the test result (1 = pass, 0 = fail)
    sw      $s1, 0($s0)        # Set 'done'

$done:
    j       $done
    nop

    .end boot
