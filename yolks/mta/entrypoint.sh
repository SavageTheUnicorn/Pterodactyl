#!/bin/bash

# GET AND EXPORT INTERNAL IP ADDRESS
export INTERNAL_IP=$(ip route get 1 2>/dev/null | awk '{print $(NF-2);exit}')

# GO TO THE DIRECTORY
cd /home/container || exit 1

# Function to download and setup start script
setup_start_script()
{
    local script_url="https://raw.githubusercontent.com/daniscript18/pterodactyl/master/scripts/start-mta.sh"
    
    echo "Setting up start script..."
    
    # Remove existing start.sh if it exists
    if [ -f start.sh ]; then
        rm -f start.sh
    fi
    
    # Download the start script
    if wget "$script_url" --no-hsts -q -O start-mta.sh; then
        # Rename it
        mv start-mta.sh start.sh
        
        # Make it executable
        chmod +x start.sh
        
        echo "Start script setup complete!"
    else
        echo "ERROR: Failed to download start script from $script_url"
        exit 1
    fi
}

# Setup the start script
setup_start_script

# CREATING START COMMAND
MODIFIED_STARTUP=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# RUN START COMMAND
echo "Executing: ${MODIFIED_STARTUP}"
exec env ${MODIFIED_STARTUP}
