set(SoftfpSrcs
  cutils.h
  softfloat-macros.h
  softfloat-specialize.h
  softfloat.c
  softfloat.h
  softfp_template_icvt.h
  softfp_template.h
  softfp.c
  softfp.h
  softfptest_template.h
  softfptest.c
  )

add_library(softfp SHARED ${SoftfpSrcs})
set_target_properties(softfp PROPERTIES LINKER_LANGUAGE CXX)
