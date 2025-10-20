#!/bin/bash
# Auto-add app to Aerospace config
# Usage: ./add_app_to_aerospace.sh "App Name" "Workspace"

if [ $# -ne 2 ]; then
    echo "Usage: $0 \"App Name\" \"Workspace\""
    echo "Example: $0 \"Safari\" \"A\""
    echo "Example: $0 \"Google Chrome\" \"B\""
    exit 1
fi

app_name="$1"
workspace="$2"
config_file="$HOME/dotfiles/aerospace/.config/aerospace/aerospace.toml"

# Get the bundle ID
bundle_id=$(osascript -e "id of app \"$app_name\"" 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$bundle_id" ]; then
    echo "Error: Could not find app '$app_name'"
    exit 1
fi

echo "App: $app_name"
echo "Bundle ID: $bundle_id"
echo "Workspace: $workspace"

# Create the new rule
new_rule="[[on-window-detected]]
if.app-id = '$bundle_id'
run = \"move-node-to-workspace $workspace\""

# Add the rule to the config file
echo "" >> "$config_file"
echo "$new_rule" >> "$config_file"

echo "✅ Added to aerospace.toml:"
echo "$new_rule"
echo ""
echo "🔄 Restart Aerospace to apply changes:"
echo "aerospace reload-config"
