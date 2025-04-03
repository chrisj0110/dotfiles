# ohmyzsh replacement:
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


# my stuff

bindkey -v # vi mode on command line
export NVIM_CONFIG="~/.config/nvim"
alias vi="nvim"

# setopt ignore_eof  # don't exit with control-d
setopt INTERACTIVE_COMMENTS  # allow comments in zsh commands

export LESS='-RFX'  # F for dont go to pager unless more than 1 screen; X for don't clear the screen after git diff, etc

alias soz="source ~/.zshrc"
alias sot="tmux source ~/.config/tmux/tmux.conf"
alias b-starship="cp ~/.config/starship.toml ~/dotfiles"

alias lazygit="lazygit -ucd ~/.config/lazygit"

alias format-json-clipboard="pbpaste | jq | pbcopy"

export t=~/temp/temp.txt

export GITHUB_EMAIL="45946825+chrisj0110@users.noreply.github.com"

alias git-github-name-and-email='git config user.name "chrisj0110" && git config user.email "45946825+chrisj0110@users.noreply.github.com"'
alias git-commit-empty-and-push='git commit --allow-empty -m "empty commit for new pipeline" && git push'

alias my-continue="echo -n continue && read _nothing"

# GCP
function gcp-deploy-app-engine() {
    # pass in GCP project id
    gcloud app deploy ~/website/app.yaml --project $1 --quiet
}
alias gcp-switch-personal="gcloud config configurations activate personal"
alias gcp-switch-default="gcloud config configurations activate default"
function gcp-deploy-cloud-function() {
    # pass in GCP project id and function name
    gcloud functions deploy $2 --gen2 --runtime=python39 --entry-point=main --memory=256MB --trigger-http --allow-unauthenticated --project $1
}

# git branches
alias gcm="git checkout master"
# alias gcmp='git fetch origin master:master && gcm'  # update master then switch to it
alias gcmp='git checkout master && git pull'  # update master then switch to it
alias gcb='git checkout -b'
alias gco='git checkout'
alias gpom='git pull --no-edit origin master'
alias gbr="git branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"
alias gbc="git rev-parse --abbrev-ref HEAD | tr -d '\n' | pbcopy"
alias gcf='git checkout `git branch --sort=-committerdate | fzf`'
alias gdb='git diff master..$(git branch --show-current) > ~/temp/out.patch'

# git misc
alias gs='git status'
alias gf="git fetch"
alias gcp='git cherry-pick'
alias gcpnc='git cherry-pick --no-commit'
alias gct='git checkout --theirs'
alias glg="git log --pretty=format:\"%C(magenta)%h%Creset -%C(yellow)%d%Creset %s %C(green)(%cr) [%an]\" --abbrev-commit -30"
alias gp="git pull"
alias gP="git push"
alias gPnv="git push -u --no-verify"
alias gc="git commit"
alias gca="git commit -am"
alias gcamsg='git commit -am "$msg"'
alias gaa="git add --all"
alias gd="git diff"
alias gds="git diff --staged"

# commit messages
alias dbg="git commit -am 'debug'"
alias dbgp="git commit -am 'debug' && git push"
alias fix="git commit -am 'fix'"
alias fixp="git commit -am 'fix' && git push"
alias rvt="git commit -am 'revert'"
alias rvtp="git commit -am 'revert' && git push"
alias wip="git commit -am 'wip'"
alias wipp="git commit -am 'wip' && git push"

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

# misc
alias tail-lsp="tail -f ~/.local/state/nvim/lsp.log"
alias tail-lsp-errors="tail -f ~/.local/state/nvim/lsp.log | grep ERROR"

export FZF_DEFAULT_OPTS=" \
--bind=ctrl-n:down,ctrl-p:up,ctrl-y:accept \
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
