# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="dracula"
# ZSH_THEME="catppuccin" -- doesn't exist

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# to install zsh-autosuggestions: git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# .. see https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



# my stuff

bindkey -v # vi mode on command line
export NVIM_CONFIG="~/.config/nvim"
alias vi="nvim"

setopt ignore_eof  # don't exit with control-d

export LESS='-RFX'  # F for dont go to pager unless more than 1 screen; X for don't clear the screen after git diff, etc

alias soz="source ~/.zshrc"
alias sot="tmux source ~/.config/tmux/tmux.conf"
alias b-starship="cp ~/.config/starship.toml ~/dotfiles"

alias lazygit="lazygit -ucd ~/.config/lazygit"

alias format-json-clipboard="pbpaste | jq | pbcopy"

export GITHUB_EMAIL="45946825+chrisj0110@users.noreply.github.com"

alias git-github-name-and-email='git config user.name "chrisj0110" && git config user.email "45946825+chrisj0110@users.noreply.github.com"'

alias my-continue="echo -n continue && read _nothing"

# GCP
function gcp-deploy-app-engine() {
    # pass in GCP project id
    gcloud app deploy ~/website/app.yaml --project $1 --quiet
}
alias gcp-switch-personal="gcloud config configurations activate personal"
alias gcp-switch-default="gcloud config configurations activate default"
function gcp-deploy-cloud-function() {
    # pass in $FUNCTION_NAME and GCP project id
    gcloud functions deploy $1 --gen2 --runtime=python39 --entry-point=main --memory=256MB --trigger-http --allow-unauthenticated --project $2
}

# git branches
alias gcm="git checkout master"
# alias gcmp='git fetch origin master:master && gcm'  # update master then switch to it
alias gcmp='git checkout master && git pull'  # update master then switch to it
alias gcb='git checkout -b'
alias gco='git checkout'
alias gpom='git pull origin master'
alias gbr="git branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"
alias gcof='git checkout `git branch --sort=-committerdate | fzf`'
alias gdb='git diff master..$(git branch --show-current) > ~/temp/out.patch'
unalias gbd  # oh-my-zsh maps to git branch --delete ?

# git misc
alias gs='git status'
alias gf="git fetch"
alias gcp='git cherry-pick'
alias gcpnc='git cherry-pick --no-commit'
alias gct='git checkout --theirs'
alias glg="git log --pretty=format:\"%C(magenta)%h%Creset -%C(yellow)%d%Creset %s %C(green)(%cr) [%an]\" --abbrev-commit -30"
alias gp="git pull"
alias gpu="git push"
alias gpnv="git push -u --no-verify"
alias gca="git commit -am"
alias gcamsg='git commit -am "$msg"'
alias gaa="git add --all"
alias gd="git diff"
alias gds="git diff --staged"

function gdhash() {
    git diff $1^..$1
}
function gdno() {
    git diff --name-only $1^..$1
}
function gdnol() {
    # name-only diff of last commit
    gdno `glg | head -1 | awk '{print $1}'`
}
function gdlast() {
    gdhash `glg | head -1 | awk '{print $1}'`
}

# git stash
alias gsl='git stash list'
alias gsp='git stash pop'  # note: git stash push {files} to only stash certain changes
alias gsa='git stash apply'  # add stash@{1} or 1 or whatever after this. apply keeps it in the stash also

# go
alias go-br="go build && go run main.go"

# rust playground - setup using `cargo new rust_playground --bin` from home dir
alias rp="cargo run --manifest-path ~/rust_playground/Cargo.toml"

# til
# alias til='vi -c ":cd ~/til | :lua my_exact_live_grep()"'

# from Taylor: jwt [encoded-value]
function jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# catppuccin codes
export rosewater=$'\033[38;2;245;224;220m'
export flamingo=$'\033[38;2;242;205;205m'
export pink=$'\033[38;2;245;194;231m'
export mauve=$'\033[38;2;203;166;247m'
export red=$'\033[38;2;243;139;168m' # works
export maroon=$'\033[38;2;235;160;172m'
export peach=$'\033[38;2;250;179;135m'
export yellow=$'\033[38;2;249;226;175m' # works
export green=$'\033[38;2;166;227;161m' # works
export teal=$'\033[38;2;148;226;213m'
export sky=$'\033[38;2;137;220;235m'
export sapphire=$'\033[38;2;116;199;236m'
export blue=$'\033[38;2;137;180;250m' # works
export lavender=$'\033[38;2;180;190;254m'
export text=$'\033[38;2;205;214;244m'
export subtext1=$'\033[38;2;186;194;222m'
export subtext0=$'\033[38;2;166;173;200m'
export overlay2=$'\033[38;2;147;153;178m'
export overlay1=$'\033[38;2;127;132;156m'
export overlay0=$'\033[38;2;108;112;134m'
export surface2=$'\033[38;2;88;91;112m'
export surface1=$'\033[38;2;69;71;90m'
export surface0=$'\033[38;2;49;50;68m'
export base=$'\033[38;2;30;30;46m'
export mantle=$'\033[38;2;24;24;37m'
export crust=$'\033[38;2;17;17;27m'
export clear=$'\033[0m'

# # USER PROMPT
# autoload -Uz vcs_info
# precmd_vcs_info() {
#     vcs_info
# }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
# # Format the vcs_info_msg_0_ variable
# zstyle ':vcs_info:git:*' formats '%b'
#
# NL=$'\n'
# PS1='$NL%B%F{blue}%3~%f%b %F{yellow}${vcs_info_msg_0_}$NL%B%(?.%F{green}.%F{red})%(!.#.>)%f%b '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zshrc-local ] && source ~/.zshrc-local
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# now load zsh-syntax-highlighting plugin
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export NERD_FONT=JetBrainsMono
export NERD_FONT_SIZE=14

eval "$(starship init zsh)"

eval "$(zoxide init --cmd cd zsh)"


# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Created by `pipx` on 2024-11-19 16:57:13
export PATH="$PATH:~/.local/bin"
