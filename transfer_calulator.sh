#!/bin/bash

PS3="Select capacity unit: "

units=("MB" "GB" "EXIT")

select choice in "${units[@]}"; do
        case "$choice" in
        "MB")
        capacity_unit="MB"
        break
        ;;
        "GB")
        capacity_unit="GB"
        gigabytes=true
        break
        ;;
        "EXIT")
        break
        ;;
        *)
        echo "Invalid option. Please enter a number [1-3]"
        ;;
        esac
done

time_calculator() {
        if [ "$gigabytes" = true ]; then
                file_size=$(echo "$file_size * 1024" | bc)
        fi

        seconds_time=$(echo "scale=2; $file_size / $transfer_speed" | bc)
        minutes_time=$(echo "scale=0; $seconds_time / 60" | bc)
        seconds_time=$(echo "scale=2; $seconds_time % 60" | bc)
        hours_time=$(echo "scale=0; $minutes_time / 60" | bc)
        minutes_time=$(echo "scale=0; $minutes_time % 60" | bc)

        echo "Time to transfer = $hours_time:$minutes_time:$seconds_time"
}

read -p "Enter file size in numeric value (10, 100, 1000): " file_size
read -p "Enter the transfer speed in numeric format MB/ps (25, 52.5, 80): " transfer_speed

numeric_pattern='^[0-9]+([.][0-9]+)?$'

if [[ $file_size =~ $numeric_pattern && $transfer_speed =~ $numeric_pattern ]]; then
        time_calculator
else
    echo "Please enter valid values."
fi

