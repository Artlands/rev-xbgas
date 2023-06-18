# Specify the source files for the softfp library
set(SOFTFP_SOURCES
    softfp.c
)

# Build the softfp library as a C library target
add_library(softfp STATIC ${SOFTFP_SOURCES})

target_include_directories(softfp PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Add the -fPIC flag for compilation
set_target_properties(softfp PROPERTIES POSITION_INDEPENDENT_CODE ON)
