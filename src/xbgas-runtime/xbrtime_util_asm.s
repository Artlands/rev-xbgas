#
# _XBRTIME_UTIL_ASM_S_
#
# Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

  .globl __xbrtime_asm_fence
  .type __xbrtime_asm_fence, @function
__xbrtime_asm_fence:
  fence.i
  ret
  .size __xbrtime_asm_fence, .-__xbrtime_asm_fence

  .globl __xbrtime_asm_quiet_fence
  .type __xbrtime_asm_quiet_fence, @function
__xbrtime_asm_quiet_fence:
  fence
  ret
  .size __xbrtime_asm_quiet_fence, .-__xbrtime_asm_quiet_fence
  