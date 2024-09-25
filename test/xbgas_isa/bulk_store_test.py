import subprocess
import csv
import re
import matplotlib.pyplot as plt

# List of instructions and their max nelem values
instructions = {
    "ebsb": 134217728,
    "ebsh": 134217728,
    "ebsw": 134217728,
    "ebsd": 134217728
}

# List of element sizes to test (powers of 2 up to 128, then max for each instruction)
element_sizes = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
                 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216]

# Executable and SST Python script
executable = "bulk_store.exe"
sst_script = "rev-xbgas-isa-test1.py"

# CSV output file
output_csv = "bulk_store_performance.csv"


# Function to run SST command and capture output
def run_sst_command(nelem, instruction):
    try:
        # Run the SST command with subprocess
        sst_command = f"sst {sst_script} --model-options=\"{executable} {nelem} {instruction}\""
        result = subprocess.run(sst_command, shell=True, capture_output=True, text=True)
        return result.stdout
    except Exception as e:
        print(f"Error running SST command for {instruction} with nelem={nelem}: {e}")
        return None


# Function to extract simulation time from SST output
def extract_sim_time(output):
    match = re.search(r'Simulation is complete, simulated time: ([0-9.]+ [numsk]+)', output)
    if match:
        return match.group(1)
    return None


# Convert time to nanoseconds for consistent plotting
def convert_time_to_ns(time_str):
    if 'ns' in time_str:
        return float(time_str.replace(' ns', ''))
    elif 'us' in time_str:
        return float(time_str.replace(' us', '')) * 1_000
    elif 'ms' in time_str:
        return float(time_str.replace(' ms', '')) * 1_000_000
    elif 's' in time_str:
        return float(time_str.replace(' s', '')) * 1_000_000_000


# Data collection for plotting
plot_data = {}

# Write the CSV header
with open(output_csv, mode='w', newline='') as csvfile:
    csvwriter = csv.writer(csvfile)
    csvwriter.writerow(["Instruction", "Nelem", "SimulatedTime"])

    # Loop through each instruction
    for instruction, max_nelem in instructions.items():
        nelem_list = []
        sim_time_list = []

        # Loop through each element size, stopping when the element size exceeds max_nelem
        for nelem in element_sizes:
            if nelem <= max_nelem:
                print(f"Running SST simulation for instruction {instruction} with nelem={nelem}")

                # Run the SST command and get the output
                sst_output = run_sst_command(nelem, instruction)

                if sst_output:
                    # Extract the simulated time from the output
                    sim_time = extract_sim_time(sst_output)

                    # Check if we successfully extracted the time
                    if sim_time:
                        # Write the result to the CSV file
                        csvwriter.writerow([instruction, nelem, sim_time])

                        # Append data for plotting, converting time to ns
                        nelem_list.append(nelem)
                        sim_time_list.append(convert_time_to_ns(sim_time))
                    else:
                        print(f"Failed to extract simulation time for {instruction} with nelem={nelem}")
            else:
                print(f"Skipping nelem={nelem} for instruction {instruction} (exceeds max_nelem={max_nelem})")

        # Add data for plotting if it's available
        if nelem_list and sim_time_list:
            plot_data[instruction] = (nelem_list, sim_time_list)

print(f"Results saved to {output_csv}")

# Generate line plot for each instruction
plt.figure(figsize=(10, 6))
for instruction, (nelem_list, sim_time_list) in plot_data.items():
    plt.plot(nelem_list, sim_time_list, label=instruction, marker='o')

# Add labels and title
plt.xlabel('Number of Elements Stored')
plt.ylabel('Time (ns)')
plt.title('Bulk Store Performance')
plt.legend(title='Instruction')
plt.grid(True)

# # Show the plot
# plt.show()
plt.savefig('bulk_store_performance.png')
