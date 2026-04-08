export XDG_SESSION_TYPE=wayland
export XDG_CONFIG_HOME="$HOME/.config"
[ -f $XDG_CONFIG_HOME/shortcutrc ] && source $XDG_CONFIG_HOME/shortcutrc
alias vim='nvim'
alias v='nvim'
alias vi='nvim'
alias g='git'
alias gsu='git status -uno'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpf='git pull --ff-only'
alias gd='git diff'
alias gl='git log --oneline'
alias glf='git log --graph --pretty=format:"%C(auto)%h%C(reset) %ad %C(auto)%d%C(reset) %s" --date=format:"%b %d, %Y"'
alias x='exit'
alias lt='ls -lt | head'
alias pai='sudo pacman -S --needed'
alias gcal='mamba run -n gcalcli-311 gcalcli --calendar "linn.official@gmail.com"'
alias m='neomutt'
alias bm='bashmount'
alias xn='source tomb-mount && cd $NOTES_TOMB'
alias here='printf '\''cd "%s"'\'' "$(pwd)" | wl-copy'
alias sc='scrcpy --legacy-paste --video-codec=h265 --max-size=1920 --max-fps=60 --no-audio --keyboard=aoa'
alias mc='mc --skin=darkfar'
export EDITOR=/usr/bin/nvim
export NOTES_TOMB=/run/media/$USER/notesbox

function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/opt/miniforge/bin/mamba';
export MAMBA_ROOT_PREFIX='/opt/miniforge';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

setopt PROMPT_SUBST
dir_abbrev() {
  local parts out IFS
  IFS='/'
  # replace $HOME with ~ for nicer output
  local cwd=${PWD/#$HOME/~}
  parts=(${(s:/:)cwd})

  # if first element was empty (absolute path), keep leading slash
  [[ $cwd == /* ]] && out='/'

  # compress all but last element to first letter
  for ((i=1; i<${#parts}; i++)); do
    out+="${parts[i]:0:1}/"
  done

  # append full last element if exists
  [[ ${#parts} -gt 0 ]] && out+="${parts[-1]}"
  echo -n $out
}
# Add git info to PROMPT
parse_git_hash() {
if git rev-parse --is-inside-work-tree &>/dev/null; then git rev-parse --short HEAD 2>/dev/null ;fi
}

# Auto-install git-prompt.sh if missing
GIT_PROMPT="$HOME/.git-prompt.sh"

if [ ! -f "$GIT_PROMPT" ]; then
    echo "Installing git-prompt.sh..."
    curl -fLo "$GIT_PROMPT" \
        https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
fi

source $GIT_PROMPT

PROMPT="\$(parse_git_hash)\$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1)$(dir_abbrev) %# "

# temporary fix for kitty and less conflict
#export PAGER="env TERM=xterm-256color less"
export TERM=xterm-256color
# fix for cheat pager not finding proper height of terminal
export COLUMNS
export LINES

function wedit(){
    $EDITOR $(which $1)
}
export PATH="$HOME/.npm-global/bin:$PATH"
