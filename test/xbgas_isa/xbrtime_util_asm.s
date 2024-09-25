#
# _XBRTIME_UTIL_ASM_S_
#
# Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# This file is a part of the XBGAS-RUNTIME package.  For license
# information, see the LICENSE file in the top level directory
# of the distribution.
#

# e10 = contains the physical PE id
# e11 = contains the number of PEs
# e12 = contains the size of the shared memory region
# e13 = contains the starting address of the physical shared memory region

  .file "xbrtime_util_asm.s"
  .text
  .align 1

  .global __xbrtime_asm_get_id
  .type __xbrtime_asm_get_id, @function
__xbrtime_asm_get_id:
  eaddi a0,e10,0
  ret
  .size __xbrtime_asm_get_id, .-__xbrtime_asm_get_id

  .global __xbrtime_asm_get_npes
  .type __xbrtime_asm_get_npes, @function
__xbrtime_asm_get_npes:
  eaddi a0,e11,0
  ret
  .size __xbrtime_asm_get_npes, .-__xbrtime_asm_get_npes

  .global __xbrtime_wait_bulk_comp
  .type __xbrtime_wait_bulk_comp, @function
__xbrtime_wait_bulk_comp:
  .wait_loop:
    csrr t0, 0xca0
    beqz t0, .wait_loop
    ret
  .size __xbrtime_wait_bulk_comp, .-__xbrtime_wait_bulk_comp
