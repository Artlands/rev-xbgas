cmake_minimum_required(VERSION 3.10)

project(xbrtime C CXX ASM)

# Override the default compiler/assembler
set(CMAKE_C_COMPILER riscv64-unknown-elf-gcc)
set(CMAKE_ASM_COMPILER riscv64-unknown-elf-gcc)

# Ensure we're using C11
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=rv64imafd_zicsr_zifencei -std=c11")

# Set the build type to debug by default
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Debug)
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D_XBGAS_DEBUG_")

# Set the output directory for the library
# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Set the source directory
set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

# Find all C source files
file(GLOB_RECURSE C_SOURCES ${SOURCE_DIR}/src/*.c)

# Find all header files
file(GLOB_RECURSE C_HEADERS ${SOURCE_DIR}/include/*.h)

# Find all assembly source files
file(GLOB_RECURSE ASM_SOURCES ${SOURCE_DIR}/asm/*.s)

# Create a static library from the C and assembly source files
add_library(xbrtime STATIC ${C_SOURCES} ${C_HEADERS} ${ASM_SOURCES})

set_target_properties(xbrtime PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)

# Add any additional compiler flags you need
# target_compile_options(xbrtime PRIVATE -Wall -Wextra -Wpedantic)

# Specify the installation targets
install(TARGETS xbrtime DESTINATION lib)
install(FILES ${C_HEADERS} DESTINATION include)

# Define the "clean" target
add_custom_target(clean-all
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_BINARY_DIR}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMENT "Cleaning xbrtime build artifacts"
)
