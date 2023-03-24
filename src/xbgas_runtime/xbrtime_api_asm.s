#
# _XBRTIME_API_ASM_S_
#
# Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

  .file "xbrtime_api_asm.s"
  .text
  .align 1

  # ---------------------------------------------------
  # xBGAS ASM API functions are formatted as follows:
  # __xbrtime_{get,put}_OPERAND_{seq,agg}
  #   where,
  #   - {get,put} correponds to receive and send
  #   - OPERAND is one of:
  #     - u1 = unsigned one byte
  #     - u2 = unsigned two byte
  #     - u4 = unsigned four byte
  #     - u8 = unsigned eight byte
  #     - s1 = signed one byte
  #     - s2 = signed two byte
  #     - s4 = signed four byte
  #     - s8 = signed eight byte
  #   - {seq,agg} corresponds to sequential
  #             and aggregated transfers
  # ---------------------------------------------------
  # Sequential Calling Convention
  #   - a0 = base src address
  #   - a1 = base dest address
  #   - a2 = remote pe
  #   - a3 = nelems
  #   - a4 = stride (in bytes)
  # ---------------------------------------------------

  .global __xbrtime_get_u1_seq
  .type __xbrtime_get_u1_seq, @function
__xbrtime_get_u1_seq:
  eaddie e10, a2, 0       # set the extended register of x10 with value in a2 (x12)
  mv x31, zero            # initialize x31 and set it to 0
.get_u1_seq:  
  elbu x30, 0(a0)         # remote load unsigned bytes from [e10+x10] and save in x30
  add a0, a0, a4          # update x10 by adding the previous value to stride, i.e., update the remote address to the next strided address
  add x31,x31,1           # add 1 to x31; x31 is used for counting the number of elements
  sb x30, 0(a1)           # store the value in x30 (i.e., the remote loaded value) to the address in a1.
  add a1, a1, a4          # update the destination address by moving to the next strided address
  bne x31,a3,.get_u1_seq  # determine if all nelems have been loaded.
  ret
  .size __xbrtime_get_u1_seq, .-__xbrtime_get_u1_seq

  # ---------------------------------------------------

  .global __xbrtime_get_u1_agg
  .type __xbrtime_get_u1_agg, @function
__xbrtime_get_u1_agg:
  eaddie e10, a2, 0       # set the extended register of x10
  eag a1, a3, a4          # enable aggregation request.
  elbu a1, 0(a0)         # remote load unsigned bytes from [e10+x10]
  ret
  .size __xbrtime_get_u1_agg, .-__xbrtime_get_u1_agg

  # ---------------------------------------------------
  
  .global __xbrtime_get_u2_seq
  .type __xbrtime_get_u2_seq, @function
__xbrtime_get_u2_seq:
  eaddie e10, a2, 0
  mv x31, zero
.get_u2_seq:
  elhu x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  sh x30, 0(a1)
  add a1, a1, a4
  bne x31,a3,.get_u2_seq
  ret
  .size __xbrtime_get_u2_seq, .-__xbrtime_get_u2_seq

  # ---------------------------------------------------

  .global __xbrtime_get_u2_agg
  .type __xbrtime_get_u2_agg, @function
__xbrtime_get_u2_agg:
  eaddie e10, a2, 0
  eag a1, a3, a4
  elhu a1, 0(a0)
  ret
  .size __xbrtime_get_u2_agg, .-__xbrtime_get_u2_agg

  # ---------------------------------------------------

  .global __xbrtime_get_u4_seq
  .type __xbrtime_get_u4_seq, @function
__xbrtime_get_u4_seq:
  eaddie e10, a2, 0
  mv x31, zero
.get_u4_seq:
  elw x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  sw x30, 0(a1)
  add a1, a1, a4
  bne x31,a3,.get_u4_seq
  ret
  .size __xbrtime_get_u4_seq, .-__xbrtime_get_u4_seq

  # ---------------------------------------------------

  .global __xbrtime_get_u4_agg
  .type __xbrtime_get_u4_agg, @function
__xbrtime_get_u4_agg:
  eaddie e10, a2, 0
  eag a1, a3, a4
  elw a1, 0(a0)
  ret
  .size __xbrtime_get_u4_agg, .-__xbrtime_get_u4_agg

  # ---------------------------------------------------

  .global __xbrtime_get_u8_seq
  .type __xbrtime_get_u8_seq, @function
__xbrtime_get_u8_seq:
  eaddie e10, a2, 0
  mv x31, zero
.get_u8_seq:
  eld x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  sd x30, 0(a1)
  add a1, a1, a4
  bne x31,a3,.get_u8_seq
  ret
  .size __xbrtime_get_u8_seq, .-__xbrtime_get_u8_seq

  # ---------------------------------------------------

  .global __xbrtime_get_u8_agg
  .type __xbrtime_get_u8_agg, @function
__xbrtime_get_u8_agg:
  eaddie e10, a2, 0
  eag a1, a3, a4
  eld a1, 0(a0)
  ret
  .size __xbrtime_get_u8_agg, .-__xbrtime_get_u8_agg

  # ---------------------------------------------------

  .global __xbrtime_get_s1_seq
  .type __xbrtime_get_s1_seq, @function
__xbrtime_get_s1_seq:
  eaddie e10, a2, 0
  mv x31, zero
.get_s1_seq:
  elb x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  sb x30, 0(a1)
  add a1, a1, a4
  bne x31,a3,.get_s1_seq
  ret
  .size __xbrtime_get_s1_seq, .-__xbrtime_get_s1_seq

  # ---------------------------------------------------

  .global __xbrtime_get_s1_agg
  .type __xbrtime_get_s1_agg, @function
__xbrtime_get_s1_agg:
  eaddie e10, a2, 0
  eag a1, a3, a4
  elb a1, 0(a0)
  ret
  .size __xbrtime_get_s1_agg, .-__xbrtime_get_s1_agg

  # ---------------------------------------------------

  .global __xbrtime_get_s2_seq
  .type __xbrtime_get_s2_seq, @function
__xbrtime_get_s2_seq:
  eaddie e10, a2, 0
  mv x31, zero
.get_s2_seq:
  elh x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  sh x30, 0(a1)
  add a1, a1, a4
  bne x31,a3,.get_s2_seq
  ret
  .size __xbrtime_get_s2_seq, .-__xbrtime_get_s2_seq

  # ---------------------------------------------------

  .global __xbrtime_get_s2_agg
  .type __xbrtime_get_s2_agg, @function
__xbrtime_get_s2_agg:
  eaddie e10, a2, 0
  eag a1, a3, a4
  elh a1, 0(a0)
  ret
  .size __xbrtime_get_s2_agg, .-__xbrtime_get_s2_agg

  # ---------------------------------------------------

  .global __xbrtime_get_s4_seq
  .type __xbrtime_get_s4_seq, @function
__xbrtime_get_s4_seq:
  eaddie e10, a2, 0
  mv x31, zero
.get_s4_seq:
  elw x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  sw x30, 0(a1)
  add a1, a1, a4
  bne x31,a3,.get_s4_seq
  ret
  .size __xbrtime_get_s4_seq, .-__xbrtime_get_s4_seq

  # ---------------------------------------------------

  .global __xbrtime_get_s4_agg
  .type __xbrtime_get_s4_agg, @function
__xbrtime_get_s4_agg:
  eaddie e10, a2, 0
  eag a1, a3, a4
  elw a1, 0(a0)
  ret
  .size __xbrtime_get_s4_agg, .-__xbrtime_get_s4_agg

  # ---------------------------------------------------

  .global __xbrtime_get_s8_seq
  .type __xbrtime_get_s8_seq, @function
__xbrtime_get_s8_seq:
  eaddie e10, a2, 0
  mv x31, zero
.get_s8_seq:
  eld x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  sd x30, 0(a1)
  add a1, a1, a4
  bne x31,a3,.get_s8_seq
  ret
  .size __xbrtime_get_s8_seq, .-__xbrtime_get_s8_seq

  # ---------------------------------------------------

  .global __xbrtime_get_s8_agg
  .type __xbrtime_get_s8_agg, @function
__xbrtime_get_s8_agg:
  eaddie e10, a2, 0
  eag a1, a3, a4
  eld a1, 0(a0)
  ret
  .size __xbrtime_get_s8_agg, .-__xbrtime_get_s8_agg

  # ---------------------------------------------------

  .global __xbrtime_put_u1_seq
  .type __xbrtime_put_u1_seq, @function
__xbrtime_put_u1_seq:
  eaddie e11, a2, 0
  mv x31, zero
.put_u1_seq:
  lbu x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  esb x30, 0(a1)
  add a1,a1,a4
  bne x31,a3,.put_u1_seq
  ret
  .size __xbrtime_put_u1_seq, .-__xbrtime_put_u1_seq

  # ---------------------------------------------------

  .global __xbrtime_put_u1_agg
  .type __xbrtime_put_u1_agg, @function
__xbrtime_put_u1_agg:
  eaddie e11, a2, 0
  eag a0, a3, a4
  esb a0, 0(a1)
  ret
  .size __xbrtime_put_u1_agg, .-__xbrtime_put_u1_agg

  # ---------------------------------------------------

  .global __xbrtime_put_u2_seq
  .type __xbrtime_put_u2_seq, @function
__xbrtime_put_u2_seq:
  eaddie e11, a2, 0
  mv x31, zero
.put_u2_seq:
  lhu x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  esh x30, 0(a1)
  add a1,a1,a4
  bne x31,a3,.put_u2_seq
  ret
  .size __xbrtime_put_u2_seq, .-__xbrtime_put_u2_seq

  # ---------------------------------------------------

  .global __xbrtime_put_u2_agg
  .type __xbrtime_put_u2_agg, @function
__xbrtime_put_u2_agg:
  eaddie e11, a2, 0
  eag a0, a3, a4
  esh a0, 0(a1)
  ret
  .size __xbrtime_put_u2_agg, .-__xbrtime_put_u2_agg

  # ---------------------------------------------------

  .global __xbrtime_put_u4_seq
  .type __xbrtime_put_u4_seq, @function
__xbrtime_put_u4_seq:
  eaddie e11, a2, 0
  mv x31, zero
.put_u4_seq:
  lwu x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  esw x30, 0(a1)
  add a1,a1,a4
  bne x31,a3,.put_u4_seq
  ret
  .size __xbrtime_put_u4_seq, .-__xbrtime_put_u4_seq

  # ---------------------------------------------------

  .global __xbrtime_put_u4_agg
  .type __xbrtime_put_u4_agg, @function
__xbrtime_put_u4_agg:
  eaddie e11, a2, 0
  eag a0, a3, a4
  esw a0, 0(a1)
  ret
  .size __xbrtime_put_u4_agg, .-__xbrtime_put_u4_agg

  # ---------------------------------------------------

  .global __xbrtime_put_u8_seq
  .type __xbrtime_put_u8_seq, @function
__xbrtime_put_u8_seq:
  eaddie e11, a2, 0
  mv x31, zero
.put_u8_seq:
  ld x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  esd x30, 0(a1)
  add a1,a1,a4
  bne x31,a3,.put_u8_seq
  ret
  .size __xbrtime_put_u8_seq, .-__xbrtime_put_u8_seq

  # ---------------------------------------------------

  .global __xbrtime_put_u8_agg
  .type __xbrtime_put_u8_agg, @function
__xbrtime_put_u8_agg:
  eaddie e11, a2, 0
  eag a0, a3, a4
  esd a0, 0(a1)
  ret
  .size __xbrtime_put_u8_agg, .-__xbrtime_put_u8_agg

  # ---------------------------------------------------

  .global __xbrtime_put_s1_seq
  .type __xbrtime_put_s1_seq, @function
__xbrtime_put_s1_seq:
  eaddie e11, a2, 0
  mv x31, zero
.put_s1_seq:
  lb x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  esb x30, 0(a1)
  add a1,a1,a4
  bne x31,a3,.put_s1_seq
  ret
  .size __xbrtime_put_s1_seq, .-__xbrtime_put_s1_seq

  # ---------------------------------------------------

  .global __xbrtime_put_s1_agg
  .type __xbrtime_put_s1_agg, @function
__xbrtime_put_s1_agg:
  eaddie e11, a2, 0
  eag a0, a3, a4
  esb a0, 0(a1)
  ret
  .size __xbrtime_put_s1_agg, .-__xbrtime_put_s1_agg

  # ---------------------------------------------------

  .global __xbrtime_put_s2_seq
  .type __xbrtime_put_s2_seq, @function
__xbrtime_put_s2_seq:
  eaddie e11, a2, 0
  mv x31, zero
.put_s2_seq:
  lh x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  esh x30, 0(a1)
  add a1,a1,a4
  bne x31,a3,.put_s2_seq
  ret
  .size __xbrtime_put_s2_seq, .-__xbrtime_put_s2_seq

  # ---------------------------------------------------

  .global __xbrtime_put_s2_agg
  .type __xbrtime_put_s2_agg, @function
__xbrtime_put_s2_agg:
  eaddie e11, a2, 0
  eag a0, a3, a4
  esh a0, 0(a1)
  ret
  .size __xbrtime_put_s2_agg, .-__xbrtime_put_s2_agg

  # ---------------------------------------------------

  .global __xbrtime_put_s4_seq
  .type __xbrtime_put_s4_seq, @function
__xbrtime_put_s4_seq:
  eaddie e11, a2, 0
  mv x31, zero
.put_s4_seq:
  lw x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  esw x30, 0(a1)
  add a1,a1,a4
  bne x31,a3,.put_s4_seq
  ret
  .size __xbrtime_put_s4_seq, .-__xbrtime_put_s4_seq

  # ---------------------------------------------------

  .global __xbrtime_put_s4_agg
  .type __xbrtime_put_s4_agg, @function
__xbrtime_put_s4_agg:
  eaddie e11, a2, 0
  eag a0, a3, a4
  esw a0, 0(a1)
  ret
  .size __xbrtime_put_s4_agg, .-__xbrtime_put_s4_agg

  # ---------------------------------------------------

  .global __xbrtime_put_s8_seq
  .type __xbrtime_put_s8_seq, @function
__xbrtime_put_s8_seq:
  eaddie e11, a2, 0
  mv x31, zero
.put_s8_seq:
  ld x30, 0(a0)
  add a0, a0, a4
  add x31,x31,1
  esd x30, 0(a1)
  add a1,a1,a4
  bne x31,a3,.put_s8_seq
  ret
  .size __xbrtime_put_s8_seq, .-__xbrtime_put_s8_seq

  # ---------------------------------------------------

  .global __xbrtime_put_s8_agg
  .type __xbrtime_put_s8_agg, @function
__xbrtime_put_s8_agg:
  eaddie e11, a2, 0
  eag a0, a3, a4
  esd a0, 0(a1)
  ret
  .size __xbrtime_put_s8_agg, .-__xbrtime_put_s8_agg

  # -- EOF