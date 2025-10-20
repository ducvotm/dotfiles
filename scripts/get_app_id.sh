#!/bin/bash
# Get bundle ID of a specific app
# Usage: ./get_app_id.sh "App Name"

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"App Name\""
    echo "Example: $0 \"Safari\""
    echo "Example: $0 \"Google Chrome\""
    exit 1
fi

app_name="$1"

# Get the bundle ID
bundle_id=$(osascript -e "id of app \"$app_name\"" 2>/dev/null)

if [ $? -eq 0 ] && [ -n "$bundle_id" ]; then
    echo "App: $app_name"
    echo "Bundle ID: $bundle_id"
else
    echo "Error: Could not find app '$app_name'"
    echo "Make sure the app is installed and the name is correct."
    echo ""
    echo "Common app names:"
    echo "  Safari"
    echo "  Google Chrome"
    echo "  Visual Studio Code"
    echo "  WezTerm"
    echo "  Terminal"
    echo "  Neovim"
fi
