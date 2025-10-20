#!/bin/bash

# Simple script to move recent JPG files from Downloads to wezterm/bg
# Usage: ./move_jpg_to_wezterm_bg.sh

DOWNLOADS_DIR="$HOME/Downloads"
DEST_DIR="/Users/ducvo/dotfiles/wezterm/bg"
WEZTERM_CONFIG="/Users/ducvo/dotfiles/wezterm/.wezterm.lua"

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Move only recent JPG files (last 24 hours) from Downloads to wezterm/bg
echo "Moving recent JPG files (last 24 hours) from Downloads to wezterm/bg..."

# Get list of files to move
files_to_move=$(find "$DOWNLOADS_DIR" -maxdepth 1 \( -name "*.jpg" -o -name "*.png" \) -type f -mtime -1)

if [ -z "$files_to_move" ]; then
    echo "No recent files found in Downloads."
    exit 0
fi

# Count files
files_count=$(echo "$files_to_move" | wc -l)
echo "Found $files_count recent file(s) to move:"

# Show file names with destination paths
echo "$files_to_move" | while read -r file; do
    filename=$(basename "$file")
    echo "  📁 $filename → $DEST_DIR/$filename"
done

echo ""
echo "Moving files..."

# Move the files and show progress
echo "$files_to_move" | while read -r file; do
    filename=$(basename "$file")
    mv "$file" "$DEST_DIR/"
    if [ $? -eq 0 ]; then
        echo "  ✅ Moved: $filename → $DEST_DIR/$filename"
    else
        echo "  ❌ Failed to move: $filename"
    fi
done

echo ""
echo "✅ Move operation completed!"

wezterm start --cwd /Users/ducvo/Developer/dotfiles/wezterm -- nvim "$WEZTERM_CONFIG"
