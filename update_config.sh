#!/bin/bash

# 1. Define the BASE path (User path)
BASE_DIR="/home/uttamthegoat"

# 2. Define the input file
LIST_FILE="./paths.txt"

# Check if the list file exists
if [[ ! -f "$LIST_FILE" ]]; then
    echo "Error: $LIST_FILE not found."
    exit 1
fi

echo "Source Base: $BASE_DIR"
echo "Target: $(pwd)"
echo "-------------------------"

# 3. Read the file line by line
while IFS= read -r sub_path || [[ -n "$sub_path" ]]; do
    
    # Skip empty lines
    [[ -z "$sub_path" ]] && continue

    # Clean up the sub_path (remove leading slashes if they exist)
    sub_path="${sub_path#/}"

    # Combine Base + Sub-path
    FULL_PATH="$BASE_DIR/$sub_path"

    if [[ -e "$FULL_PATH" ]]; then
        echo "Copying: $FULL_PATH"
        # -a preserves attributes, -r is recursive
        cp -ar "$FULL_PATH" ./dotfiles
    else
        echo "Error: '$FULL_PATH' not found."
    fi

done < "$LIST_FILE"

echo "-------------------------"
echo "Bulk copy complete!"