#!/bin/bash

SESSION=$1
TERMINAL_CHECK=$(tmux list-sessions | grep "^${SESSION}:")
if [ "$TERMINAL_CHECK" == "" ]; then
    tmux new-session -d -s $SESSION
fi
tmux switch-client -t $SESSION

