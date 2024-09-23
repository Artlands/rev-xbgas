#!/bin/bash

# --- Clean build
rm -rf build
mkdir -p build
cd build

# --- Configure build
cmake ..

# --- Compile & install
make -j
make install
