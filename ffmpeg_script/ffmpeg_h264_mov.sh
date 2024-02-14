#!/bin/bash
# Create Mov files from png sequences
# This script is used to convert png sequences to Mov files using FFmpeg.

# Find directories and read them into an array
readarray -t comp_paths < <(find "./png" -mindepth 1 -maxdepth 1 -type d)

# Loop through each path in the array
for comp_path in "${comp_paths[@]}"; do
    echo " "
    echo "Processing $comp_path"
    echo " "
    default_name=$(basename "$comp_path")
    input_png_file="$comp_path/"$default_name"_%04d.png"
    output_mov_folder="./mov"
    output_mov_file="$output_mov_folder/$default_name.mov"
    # ffmpeg command here
    ffmpeg -f image2 -r 24 -start_number 0001 -i "$input_png_file" -c:v libx264 -b:v 20000k -colorspace 1 -color_primaries 1 -color_trc 1 -color_range tv -pix_fmt yuv420p -y "$output_mov_file"
    echo " "
    echo "Completed processing $comp_path"
    echo " "
    #sleep 1 # Prevents the script from crashing when processing multiple files
done
