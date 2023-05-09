cmake_minimum_required(VERSION 3.10)
project(xbrtime C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_COMPILER riscv64-unknown-elf-gcc)
set(C_FLAGS "-march=rv64imafdc")

# specify the source directories
set(XBRTIME_SOURCE_DIR "src")
set(XBRTIME_INCLUDE_DIR "include")
set(XBRTIME_ASM_DIR "asm")

# set the build directory to ./build
set(CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/build)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR})

# add the source, header, and assembly files
file(GLOB XBRTIME_SOURCES "${XBRTIME_SOURCE_DIR}/*.c")
file(GLOB XBRTIME_HEADERS "${XBRTIME_INCLUDE_DIR}/*.h")
file(GLOB XBRTIME_ASM "${XBRTIME_ASM_DIR}/*.s")

# specify the output directory to ./lib
set(XBRTIME_OUTPUT_DIR "${CMAKE_SOURCE_DIR}/lib")

# create the library target
add_library(xbrtime STATIC ${XBRTIME_SOURCES} ${XBRTIME_HEADERS} ${XBRTIME_ASM})

# set the output name and location of the library
set_target_properties(xbrtime PROPERTIES 
    OUTPUT_NAME "xbrtime"
    ARCHIVE_OUTPUT_DIRECTORY "${XBRTIME_OUTPUT_DIR}"
)

# specify any additional compilation options
target_compile_options(xbrtime PRIVATE ${C_FLAGS})

# add include directories
target_include_directories(xbrtime PUBLIC ${XBRTIME_INCLUDE_DIR})

# optionally, create an install target to install the library and headers
install(TARGETS xbrtime DESTINATION lib)
install(FILES ${XBRTIME_HEADERS} DESTINATION include)
