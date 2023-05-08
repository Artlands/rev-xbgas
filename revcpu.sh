#!/bin/bash

# Check if build directory exists
if [ -d "build" ]; then
  # If it exists, remove all contents inside the build directory
  rm -rf build/*
else
  # If it doesn't exist, create the build directory
  mkdir build
fi

# Navigate to the build directory
cd build

# Run cmake command to configure build
cmake ../ #-D_XBGAS_DEBUG_=ON -D_REV_DEBUG_=ON ../

# Build the project
make

# Install the REVCPU library
make install