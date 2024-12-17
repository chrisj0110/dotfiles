#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: session name not provided"
    exit 1
fi

SESSION_NAME="$1"
CURRENT_SESSION=$(tmux display-message -p '#S')
if [ "$CURRENT_SESSION" == "$SESSION_NAME" ]; then
    # switch back to the previous session
    tmux switch-client -l
else
    # switch to requested session
    ~/dotfiles/bin/switch-or-create-session.sh $SESSION_NAME
fi
