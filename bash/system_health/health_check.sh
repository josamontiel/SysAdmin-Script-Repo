#!/bin/bash

# Check for available software updates
available_updates=$(softwareupdate -l 2>&1 | grep -E '(\*|recommended)')
if [ -n "$available_updates" ]; then
    echo "Software updates are available."
else
    echo "No software updates available."
fi

# List installed applications using Homebrew
if command -v brew &>/dev/null; then
    installed_apps=$(brew list)
    echo "Installed applications (using Homebrew):"
    echo "$installed_apps"
else
    echo "Homebrew is not installed."
fi

# Check Gatekeeper status
gatekeeper_status=$(spctl --status)
if [[ "$gatekeeper_status" == "assessments enabled" ]]; then
    echo "Gatekeeper is enabled."
else
    echo "Gatekeeper is disabled."
fi
