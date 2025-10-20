#!/bin/bash

# Simple Config Tmux Session
SESSION_NAME="config"

# Check if we're already in a tmux session
if [ -n "$TMUX" ]; then
    echo "You're already in a tmux session. Creating new session in background..."
    # Create new session in background
    tmux new-session -d -s "$SESSION_NAME" -c "$HOME/workspace/github.com/ducvotm/dotfiles"
    
    # Create windows for config management
    tmux rename-window -t "$SESSION_NAME:0" "dotfiles"
    tmux new-window -t "$SESSION_NAME:1" -n "nvim"
    tmux new-window -t "$SESSION_NAME:2" -n "tmux"
    
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
tmux new-session -d -s "$SESSION_NAME" -c "$HOME/workspace/github.com/ducvotm/dotfiles"

# Create windows for config management
tmux rename-window -t "$SESSION_NAME:0" "dotfiles"
tmux new-window -t "$SESSION_NAME:1" -n "nvim"
tmux new-window -t "$SESSION_NAME:2" -n "tmux"

# Attach to the session
tmux attach-session -t "$SESSION_NAME"
