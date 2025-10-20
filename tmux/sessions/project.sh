#!/bin/bash

# Simple Project Tmux Session
PROJECT_DIR=$(pwd)
PROJECT_NAME=$(basename "$PROJECT_DIR")  # Get the directory name as project name
SESSION_NAME="$PROJECT_NAME"  # Use project name as session name

# Check if we're already in a tmux session
if [ -n "$TMUX" ]; then
    echo "You're already in a tmux session. Creating new session in background..."
    echo "Project directory: $PROJECT_DIR"
    echo "Project name: $PROJECT_NAME"
    # Create new session in background
    tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR"
    
    # Create windows for project workflow
    tmux rename-window -t "$SESSION_NAME:0" "main"
    tmux new-window -t "$SESSION_NAME:1" -n "dev"
    tmux new-window -t "$SESSION_NAME:2" -n "test"
    
    echo "Session '$SESSION_NAME' created. Use 'tmux attach -t $SESSION_NAME' to attach to it."
    exit 0
fi

# Check if session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Session '$SESSION_NAME' already exists. Attaching..."
    tmux attach-session -t "$SESSION_NAME"
    exit 0
fi

# Create new session
tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR"

# Create windows for project workflow
tmux rename-window -t "$SESSION_NAME:0" "main"
tmux new-window -t "$SESSION_NAME:1" -n "dev"
tmux new-window -t "$SESSION_NAME:2" -n "test"

# Attach to the session
tmux attach-session -t "$SESSION_NAME"
