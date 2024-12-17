#!/bin/bash

CURRENT=$(tmux list-sessions -F '#{session_name} #{session_last_attached}' | sort -k2 -n | awk '{print $1}' | tail -1)
PREV=$(tmux list-sessions -F '#{session_name} #{session_last_attached}' | sort -k2 -n | awk '{print $1}' | tail -2 | head -1)
TWO_BACK=$(tmux list-sessions -F '#{session_name} #{session_last_attached}' | sort -k2 -n | awk '{print $1}' | tail -3 | head -1)

if [ "$PREV" == "terminal" ];
then
    # terminal was previous, so switch to two back
    tmux switch-client -t $TWO_BACK
else
    # switch back to the previous session
    tmux switch-client -l
fi

