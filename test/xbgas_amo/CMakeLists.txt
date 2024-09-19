# Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#

#include_directories(${XBGAS_PATH})

file(GLOB TEST_SRCS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.c)

project(asm_tst C ASM)

# Enable ASM language support
enable_language(ASM)

#set(CMAKE_C_COMPILER "${RISCV_ENV}/bin/riscv64-unknown-elf-gcc")
#set(CMAKE_ASM_COMPILER "${RISCV_ENV}/bin/riscv64-unknown-elf-gcc")
#set(CMAKE_C_FLAGS "-O0 -march=rv64imafdc -static")
#set(CMAKE_OSX_DEPLOYMENT_TARGET "")

set (passRegex "Simulation is complete")

# Assembly file to compile
set(ASM_SRC xbrtime_util_asm.s)
set(ASM_OBJ xbrtime_util_asm.o)

add_test(
  NAME BUILD_CLEAN
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  COMMAND make clean
)

add_test(
  NAME COMPILE_ASM
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  COMMAND ${RVAS} -c ${CMAKE_CURRENT_SOURCE_DIR}/${ASM_SRC} -o ${CMAKE_CURRENT_SOURCE_DIR}/${ASM_OBJ}
)

foreach(testSrc ${TEST_SRCS})
  # Extract the file name
  get_filename_component(testName ${testSrc} NAME_WE)

  #COMMAND sst --model-options=${CMAKE_CURRENT_SOURCE_DIR}/${testName} ./rev-xbgas-test.py)
  # Add the tests for execution
  add_test(NAME ${testName}
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  COMMAND ./run_asm_test.sh)
  set_tests_properties( ${testName}
      PROPERTIES
      ENVIRONMENT "RVASM=${testName}; RVCC=${RVCC}"
      TIMEOUT 30
      LABELS "rv64;xbgas_isa"
      PASS_REGULAR_EXPRESSION "${passRegex}")
endforeach(testSrc)
