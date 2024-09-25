#!/bin/bash

# List of instructions and their max nelem values
declare -A instructions=(
  ["eblb"]=2000
  ["eblbu"]=2000
  ["eblh"]=1000
  ["eblhu"]=1000
  ["eblw"]=500
  ["ebld"]=250
)

# List of element sizes to test (powers of 2 up to 128, then max for each instruction)
element_sizes=(2 4 8 16 32 64 96 128 192 256 512 768 1000 1024 1280 1536 1792 2000 2048)

# Executable
executable="bulk_load.exe"

# SST Python script
sst_script="rev-xbgas-isa-test1.py"

# CSV output file
output_csv="bulk_transfer_performance.csv"

# Write the CSV header
echo "Instruction,Nelem,SimulatedTime" > "$output_csv"

# Loop through each instruction
for instruction in "${!instructions[@]}"; do
  # Get the max nelem for this instruction
  max_nelem=${instructions[$instruction]}

  # Loop through each element size, stopping when the element size exceeds the max_nelem
  for nelem in "${element_sizes[@]}"; do
    if [ "$nelem" -le "$max_nelem" ]; then
      echo "Running SST simulation for instruction $instruction with nelem=$nelem"
      # Run SST with the given instruction and element size
      sst_output=$(sst $sst_script --model-options="$executable $nelem $instruction")

      # Extract the simulated time (with unit: ns, us, ms, s)
      sim_time=$(echo "$sst_output" | grep -oP 'Simulation is complete, simulated time: \K[0-9.]+ [numsk]+')

      # Check if we successfully extracted the time
      if [ -n "$sim_time" ]; then
        # Write the result to the CSV file
        echo "$instruction,$nelem,$sim_time" >> "$output_csv"
      else
        echo "Failed to extract simulation time for $instruction with nelem=$nelem"
      fi
    else
      echo "Skipping nelem=$nelem for instruction $instruction (exceeds max_nelem=$max_nelem)"
    fi
  done
done
