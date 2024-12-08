# RevCPU test/CMakeLists.txt
#
# Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#
if(NOT DEFINED TEST_LEVEL)
  set(TEST_LEVEL "$ENV{TEST_LEVEL}")
endif()

if(NOT TEST_LEVEL OR TEST_LEVEL GREATER 3 OR TEST_LEVEL LESS 1)
  set(TEST_LEVEL 3)
endif()

message("TEST_LEVEL=${TEST_LEVEL}")

set(RISCV_ENV "$ENV{RISCV}")
if(RISCV_ENV)
  message(STATUS "RISCV environment set to ${RISCV_ENV}")
else()
  message(FATAL_ERROR "RISCV environment variable is not set.")
endif()

set(RISCV_BIN_PATH "$ENV{RISCV}/bin")

# Check for RISCV C Compiler
set(RVCC "$ENV{RVCC}")
if(NOT RVCC)
  file(GLOB RVCC_FILES "${RISCV_BIN_PATH}/*gcc" "${RISCV_BIN_PATH}/*clang")
  list(GET RVCC_FILES 0 RVCC)
endif()
if(RVCC)
  message(STATUS "RVCC set to ${RVCC}")
else()
  message(FATAL_ERROR "RVCC environment varible is not set.")
endif()

set(RVCXX "$ENV{RVCXX}")
if(NOT RVCXX)
  file(GLOB RVCXX_FILES "${RISCV_BIN_PATH}/*++")
  list(GET RVCXX_FILES 0 RVCXX)
endif()
if(RVCXX)
  message(STATUS "RVCXX set to ${RVCXX}")
else()
  message(FATAL_ERROR "RVCXX environment varible is not set.")
endif()

set(RVAS "$ENV{RVAS}")
if(NOT RVAS)
  file(GLOB RVAS_FILES "${RISCV_BIN_PATH}/*as")
  list(GET RVAS_FILES 0 RVAS)
endif()
if(RVAS)
  message(STATUS "RVAS set to ${RVAS}")
else()
  message(FATAL_ERROR "RVAS environment varible is not set.")
endif()

set(RVOBJDUMP "$ENV{RVOBJDUMP}")
if(NOT RVOBJDUMP)
  file(GLOB RVOBJDUMP_FILES "${RISCV_BIN_PATH}/*objdump")
  list(GET RVOBJDUMP_FILES 0 RVOBJDUMP)
endif()
if(RVOBJDUMP)
  message(STATUS "RVOBJDUMP set to ${RVOBJDUMP}")
else()
  message(FATAL_ERROR "RVOBJDUMP environment varible is not set.")
endif()

set (passRegex "Simulation is complete")


#------- TESTS  ---------------
message(STATUS "CTest Setup")

# Macro to build and configure tests in rev based on the labels the test was specified with
macro(add_rev_test test_name test_dir timeout labels)
  string(TOLOWER ${test_dir} test_dir_lower)
  string(TOLOWER ${test_name} test_name_lower)

  # Parse arguments for an optional script
  set(optional_script "")
  cmake_parse_arguments(ARG "" "SCRIPT" "" ${ARGN})
  if(ARG_SCRIPT)
    set(optional_script ${ARG_SCRIPT})
  endif()

  # Build the test and generate disassembly
  add_custom_target(build_${test_name_lower}
    COMMAND ${CMAKE_MAKE_PROGRAM} clean
    COMMAND ${CMAKE_MAKE_PROGRAM}
    COMMAND ${RVOBJDUMP} -dC -Mno-aliases --source *.exe > ${CMAKE_CURRENT_SOURCE_DIR}/${test_dir_lower}/${test_name_lower}.asm
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${test_dir_lower}
    COMMENT "Building and disassembling ${test_name_lower} test"
  )

  # Initialize configuration variables
  set(machine_args "\"[CORES:RV64GC]\"")
  set(numHartsList 1)
  set(numCoresList 1)
  set(add_memh_test FALSE)
  set(startSymbol "\"[0:main]\"")

  set(test_level 1)
  string(FIND "${labels}" "test_level=2" test_level_2_index)
  if(NOT ${test_level_2_index} EQUAL -1)
    set(test_level 2)
  endif()
  string(FIND "${labels}" "test_level=3" test_level_3_index)
  if(NOT ${test_level_3_index} EQUAL -1)
    set(test_level 3)
  endif()

  # Adjust parameters based on the labels that are passed
  string(FIND "${labels}" "rv32" rv32_label_index)
  if(NOT ${rv32_label_index} EQUAL -1)
    set(machine_args "\"[CORES:RV32GC]\"")
  endif()

  string(FIND "${labels}" "zicntr" zicntr_label_index)
  if(NOT ${zicntr_label_index} EQUAL -1)
    set(machine_args "\"[CORES:RV64GC_zicntr]\"")
  endif()

  string(FIND "${labels}" "multihart" multihart_label_index)
  if(NOT ${multihart_label_index} EQUAL -1)
    set(numHartsList 1 2 4)
  endif()

  string(FIND "${labels}" "multicore" multicore_label_index)
  if(NOT ${multicore_label_index} EQUAL -1)
    set(numCoresList 1 2 4)
  endif()

  string(FIND "${labels}" "pthreads" multithreading_label_index)
  if(NOT ${multithreading_label_index} EQUAL -1)
    set(numHartsList 1 2 4)
    set(numCoresList 1 2 4)
  endif()

  string(FIND "${labels}" "memh" memh_label_index)
  if(NOT ${memh_label_index} EQUAL -1)
    set(add_memh_test TRUE)
  endif()

  string(FIND "${labels}" "c++" cpp_label_index)
  if(NOT ${cpp_label_index} EQUAL -1)
    #    set(startSymbol "\"[0:_start]\"")
  endif()

  if(NOT optional_script)
    foreach(numHarts IN LISTS numHartsList)
      foreach(numCores IN LISTS numCoresList)

        # Define revmem target with the new naming convention
        add_custom_target(run_${test_name_lower}_revmem_${numHarts}_harts_${numCores}_cores
          COMMAND cd ${CMAKE_CURRENT_SOURCE_DIR}/${test_name_lower} && sst --add-lib-path=${CMAKE_SOURCE_DIR}/build/src/ ${CMAKE_SOURCE_DIR}/test/rev-model-options-config.py -- --program="${test_name_lower}.exe" --numHarts=${numHarts} --numCores=${numCores} --machine "${machine_args}" --startSymbol "${startSymbol}"
          DEPENDS build_${test_name_lower}
          COMMENT "Running ${test_name_lower} test with revmem, numHarts=${numHarts}, numCores=${numCores}"
        )
        add_test(NAME ${test_name_lower}_revmem_${numHarts}_harts_${numCores}_cores COMMAND ${CMAKE_COMMAND} --build . --target run_${test_name_lower}_revmem_${numHarts}_harts_${numCores}_cores)

        if(((NOT ${rv32_label_index} EQUAL -1) AND DEFINED RV32_DISABLED) OR test_level GREATER TEST_LEVEL)
          set_tests_properties(${test_name_lower}_revmem_${numHarts}_harts_${numCores}_cores PROPERTIES DISABLED TRUE)
        endif()

        # If 'memh' label found, add a memHierarchy test
        if(add_memh_test)
          add_custom_target(run_${test_name_lower}_memh_${numHarts}_harts_${numCores}_cores
            COMMAND cd ${CMAKE_CURRENT_SOURCE_DIR}/${test_name_lower} && sst --add-lib-path=${CMAKE_SOURCE_DIR}/build/src/ ${CMAKE_SOURCE_DIR}/test/rev-model-options-config.py -- --program="${test_name_lower}.exe" --numHarts=${numHarts} --numCores=${numCores} --machine "${machine_args}" --enableMemH=1 --startSymbol "${startSymbol}"
            DEPENDS build_${test_name_lower}
            COMMENT "Running ${test_name_lower} test with memHierarchy enabled, numHarts=${numHarts}, numCores=${numCores}"
          )
          add_test(NAME ${test_name_lower}_memh_${numHarts}_harts_${numCores}_cores COMMAND ${CMAKE_COMMAND} --build . --target run_${test_name_lower}_memh_${numHarts}_harts_${numCores}_cores)
          if(((NOT ${rv32_label_index} EQUAL -1) AND DEFINED RV32_DISABLED) OR test_level GREATER TEST_LEVEL)
            set_tests_properties(${test_name_lower}_memh_${numHarts}_harts_${numCores}_cores PROPERTIES DISABLED TRUE)
          endif()
        endif()

        set_tests_properties(${test_name_lower}_revmem_${numHarts}_harts_${numCores}_cores
          PROPERTIES
          ENVIRONMENT "RVCC=${RVCC};RVCXX=${RVCXX}"
          TIMEOUT ${timeout}
          PASS_REGULAR_EXPRESSION "${passRegex}"
          LABELS "${labels}"
	)
        if(add_memh_test)
          set_tests_properties(${test_name_lower}_memh_${numHarts}_harts_${numCores}_cores
            PROPERTIES
            ENVIRONMENT "RVCC=${RVCC};RVCXX=${RVCXX}"
            TIMEOUT ${timeout}
            PASS_REGULAR_EXPRESSION "${passRegex}"
            LABELS "${labels}"
          )
        endif()
      endforeach()
    endforeach()
  else()
    # Custom target for running the specified script
    add_custom_target(run_${test_name_lower}_script
      COMMAND ${CMAKE_COMMAND} -E echo "Executing script ${optional_script}"
      COMMAND bash ${optional_script}
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${test_dir_lower}
      DEPENDS build_${test_name_lower}
      COMMENT "Running script for ${test_name_lower} test"
    )

    # Add the custom target as a test
    add_test(NAME ${test_name_lower}_script COMMAND ${CMAKE_COMMAND} --build . --target run_${test_name_lower}_script)

    # Set test properties for the script test
    set_tests_properties(${test_name_lower}_script
      PROPERTIES
      ENVIRONMENT "RVCC=${RVCC};RVCXX=${RVCXX}"
      TIMEOUT ${timeout}
      PASS_REGULAR_EXPRESSION "${passRegex}"
      LABELS "${labels}"
    )
    if(((NOT ${rv32_label_index} EQUAL -1) AND DEFINED RV32_DISABLED) OR test_level GREATER TEST_LEVEL)
      set_tests_properties(${test_name_lower}_script PROPERTIES DISABLED TRUE)
    endif()
  endif()
endmacro()

# Not all toolchains have support RV32, so we test and skip RV32 tests with a warning
execute_process(COMMAND ${RVCC} -march=rv32i -mabi=ilp32 -o /dev/null ex1.c WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/ex1 ERROR_VARIABLE RV32_Missing)
if(RV32_Missing MATCHES "Cannot find suitable multilib set for '-march=rv32")
  set(RV32_DISABLED TRUE)
  message(WARNING "RV32 tests disabled because ${RVCC} does not support RV32")
endif()

# add_rev_test(test_name test_dir timeout labels)
add_rev_test(EXT_VERSION ext_version 20 "rv64")
add_rev_test(EX1 ex1 30 "memh;rv32")
add_rev_test(EX2 ex2 30 "memh;rv64")
add_rev_test(EX3 ex3 30 "memh;rv32")
add_rev_test(EX4 ex4 30 "memh;rv32")
add_rev_test(EX5 ex5 30 "memh;rv64")
add_rev_test(EX6 ex6 45 "memh;rv64")
add_rev_test(EX7 ex7 30 "memh;rv64")
add_rev_test(BIG_LOOP big_loop 140 "test_level=2;rv64;benchmark")
add_rev_test(LARGE_BSS large_bss 60 "test_level=2;memh;rv64")
add_rev_test(DEP_CHECK dep_check 30 "memh;rv32")
add_rev_test(CACHE_1 cache_1 30 "memh;rv32" SCRIPT "run_cache_1.sh")
add_rev_test(CACHE_2 cache_2 30 "memh;rv64" SCRIPT "run_cache_2.sh")
add_rev_test(STRLEN_C strlen_c 30 "memh;rv64")
add_rev_test(STRLEN_CXX strlen_cxx 30 "memh;rv64;c++")
add_rev_test(STRSTR strstr 30 "memh;rv64")
add_rev_test(MEMSET memset 30 "memh;rv64")
add_rev_test(MEMSET_2 memset_2 90 "test_level=2;memh;rv64")
add_rev_test(MANY_CORE many_core 30 "memh;rv64" SCRIPT "run_many_core.sh")
add_rev_test(DIVW divw 30 "memh;rv64")
add_rev_test(DIVW2 divw2 30 "memh;rv64")
add_rev_test(X0 x0 30 "memh;rv64")
add_rev_test(ARGC argc 30 "test_level=2;memh;rv64;loader;" SCRIPT "run_argc.sh")
add_rev_test(ARGC_SHORT argc_short 30 "test_level=2;memh;rv64;loader;" SCRIPT "run_argc_short.sh")
add_rev_test(ARGV argv 30 "test_level=2;memh;rv64;loader;c++" SCRIPT "run_argv.sh")
add_rev_test(ARGV_layout argv_layout 30 "test_level=2;memh;rv32;loader;" SCRIPT "run_argv_layout.sh")
add_rev_test(ARGV_limit argv_limit 90 "test_level=2;memh;rv32;loader;" SCRIPT "run_argv_limit.sh")
add_rev_test(ARGV_stack argv_stack 10 "memh;rv64")
add_rev_test(COPROC_EX coproc_ex 30 "memh;rv64;coproc" SCRIPT "run_coproc_ex.sh")
add_rev_test(ZICBOM zicbom 45 "test_level=2;memh;rv64" SCRIPT "run_zicbom.sh")

add_rev_test(BACKINGSTORE backingstore 100 "test_level=2;rv64" SCRIPT "run_backingstore.sh")
add_rev_test(MEM_DUMP mem_dump 10 "rv64" SCRIPT "run_mem_dump.sh")
add_rev_test(LWSP lwsp 30 "test_level=2;memh;rv64")
add_rev_test(CSR csr 30 "rv64")
add_rev_test(RDCYCLE rdcycle 5 "test_level=2;rv64;zicntr")
add_rev_test(RDTIME rdtime 5 "test_level=2;rv64;zicntr")
add_rev_test(RDINSTRET rdinstret 5 "test_level=2;memh;rv64;zicntr")
add_rev_test(Zfa zfa 30 "rv64" SCRIPT "run_zfa_tests.sh")

# Not all toolchains have support for Zfa yet, so we test and skip Zfa tests with a warning
execute_process(COMMAND ${RVCXX} -c -march=rv64gc_zfa zfa.cc WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/zfa ERROR_VARIABLE ZFA_Missing)
if(ZFA_Missing MATCHES "unknown prefixed ISA extension .zfa")
  set_tests_properties(zfa_script PROPERTIES DISABLED TRUE)
  message(WARNING "Zfa tests being skipped because ${RVCXX} does not support Zfa")
endif()

# add_rev_test(TRACER tracer 30 "rv64;tracer")
# add_rev_test(PAN_TEST1 pan_test1 30 "rv64;pan")
# add_rev_test(PAN_TEST2 pan_test2 30 "rv64;pan")
# add_rev_test(DOT_SINGLE dot_single 30 "rv64;blas-required")
# add_rev_test(DOT_DOUBLE dot_double 30 "rv64;blas-required")
# add_rev_test(BGE_BLE bge_ble 30 "rv64")

add_subdirectory(isa)
add_subdirectory(xbgas_isa)
add_subdirectory(xbgas_amo)
add_subdirectory(amo)
add_subdirectory(benchmarks)
add_subdirectory(syscalls)
add_subdirectory(threading)
add_subdirectory(cxx)
add_subdirectory(fenv)

# EOF
