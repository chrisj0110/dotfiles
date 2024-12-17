# Notes:
# oura.sh needs to go in ~/.config/tmux/plugins/tmux/custom/
# then put these lines in tmux.conf:
# set -g @catppuccin_status_modules_right "oura application session"
# set -g @catppuccin_oura_text "#($HOME/oura/target/debug/oura)"
# and build oura: `cd ~/oura; cargo build`

# figured this out from here: https://www.youtube.com/watch?v=uok-bsHq-sQ

# see oura API here: https://cloud.ouraring.com/v2/docs
# and how to get a token here: https://cloud.ouraring.com/docs/authentication#personal-access-tokens
# set the token to $OURA_ACCESS_TOKEN

# ---

# If this module depends on an external Tmux plugin, say so in a comment.
# E.g.: Requires https://github.com/aaronpowell/tmux-weather

show_oura() { # This function name must match the module name!
  local index icon color text module

  index=$1 # This variable is used internally by the module loader in order to know the position of this module
  icon="$(  get_tmux_option "@catppuccin_oura_icon"  ""           )"
  color="$( get_tmux_option "@catppuccin_oura_color" "$thm_red"    )"
  text="$(  get_tmux_option "@catppuccin_oura_text"  "hello world" )"

  module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}

