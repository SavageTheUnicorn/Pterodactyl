#!/bin/bash

# FUNCTION TO INSTALL MTA DEPENDENCIES
install_mta_dependencies()
{
    # DEPENDENCIES INSTALLATION PROCESS
    echo "Installing MTA dependencies..."
    apt update -y
    apt install -y libncursesw5
    
    # Download MySQL client library for MTA
    mkdir -p /usr/lib
    wget -q -P /usr/lib/ https://nightly.mtasa.com/files/modules/64/libmysqlclient.so.16
    
    echo "MTA dependencies installed successfully!"
}

# MAIN FUNCTION
main()
{
    # INSTALL MTA DEPENDENCIES
    # NOTE: Box64 is no longer needed as MTA 1.6.0+ has native ARM64 support
    install_mta_dependencies
}

# LOAD MAIN FUNCTION
main
