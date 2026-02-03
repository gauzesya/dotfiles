#!/bin/bash

# Install mise if not already installed
if ! command -v mise &> /dev/null; then
    echo "Installing mise..."
    curl https://mise.run | sh
else
    echo "mise is already installed"
fi
