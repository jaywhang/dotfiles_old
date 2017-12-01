#!/bin/bash

# Make sure there's only one argument
if [ $# -lt 1 ]; then
    echo "No argument given!"
    exit 1
elif [ $# -gt 1 ]; then
    echo "Too many arguments given!"
    exit 1
fi

# Extract the filename and the extension
filename=$(basename "$1")
ext="${filename##*.}"
name="${filename%.*}"

# Check if the given filename contains an extension
# and set $name and $ext accordingly
if [[ "$filename" != *\.* ]]; then
    ext=""
fi
if [ "$name" == "" ]; then
    name="$filename"
fi

# Compile the code
gcc -lglut -lGL -lGLU -lX11 -lXmu -lXi -lm -o "$name" "$1"
