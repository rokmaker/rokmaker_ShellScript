#!/bin/bash
# Create Mov files from png sequences
# This script is used to convert png sequences to Mov files using FFmpeg.

# Find directories and read them into an array
readarray -t comp_paths < <(find "./png" -mindepth 1 -maxdepth 1 -type d)

# Create folders if they do not exist
mkdir -p "./mov" "./png/_out"

# Loop through each path in the array
for comp_path in "${comp_paths[@]}"; do
    echo " "
    echo "Processing $comp_path"
    echo " "
    # If _out folder in array, skip it
    if [[ $comp_path == *"_out"* ]]; then
        echo "Skipping $comp_path"
        echo " "
        continue
    fi
    # Set the variables
    default_name=$(basename "$comp_path")
    input_png_file="$comp_path/"$default_name"_%04d.png"
    output_mov_folder="./mov"
    output_mov_file="$output_mov_folder/$default_name.mov"
    # ffmpeg command here
    ffmpeg -f image2 -r 24 -start_number 0001 -i "$input_png_file" -c:v libx264 -b:v 20000k -colorspace 1 -color_primaries 1 -color_trc 1 -color_range tv -pix_fmt yuv420p -y "$output_mov_file"
    echo " "
    # Move the processed comp_path folder to the _out folder
    mv "$comp_path" "./png/_out"
    echo "Completed processing $comp_path"
    echo " "
done

# Notify user that the all of the rendering processes are complete
echo -e "\033[0;31mRendering complete\033[0m"
echo " "

# End of script