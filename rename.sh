#!/bin/bash

# Offset value to be added to the first two characters
OFFSET=$1

echo "OFFSET is $OFFSET"

# Loop through all files in the directory
for file in *; do
    # Check if the file is a regular file
    if [ -f "$file" ]; then
        # Extract the first two characters (which are numbers)
        number="${file:0:2}"
        
        # Check if the first two characters are indeed numbers
        if [[ "$number" =~ ^[0-9]{2}$ ]]; then

            # Force interpretation of the number as decimal, even if it has leading zeros
            decimal_number=$((10#$number))

            # Calculate the new number with the offset
            new_number=$(printf "%02d" $((decimal_number + OFFSET)))

            # print the new number
            echo "New number $new_number"
            
            # Create the new filename by replacing the old number with the new number
            new_filename="${new_number}${file:2}"

            #print new filename
            echo "New filename $new_filename"
            echo "Ok? "
            read OK
            if [ '$OK' = 'n' ]; then
                exit
            fi
            
            # Rename the file
            mv "$file" "$new_filename"
            
            echo "Renamed '$file' to '$new_filename'"
        fi
    fi
done
