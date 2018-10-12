echo -e "\033[0;31m\
                (
   )            )\    )   )   (
  /((   (   (  ((_)( /(  /((  )\   (
 (_))\  )\  )\  _  )(_))(_))\((_)  )\ )
 _)((_)((_)((_)| |((_)_ _)((_)(_) _(_/(
 \ V // _|/ _ \| |/ _' |\ V / | || ' \))
  \_/ \__|\___/|_|\__,_| \_/  |_||_||_|
"

# set tab length to 2 spaces
tabs -2

# tell less to display tabs as 2 spaces also.
# this makes `git diff` (and anything else that uses less as its pager)
# vastly more readable, because it defaults to 8.
export LESS='eFRX-x2'

# Path for brew
test -d /usr/local/bin && export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Load nvm bash completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Load git completions
git_completion_script=/usr/local/etc/bash_completion.d/git-completion.bash
test -s $git_completion_script && source $git_completion_script



c_black='\[\e[0;30m\]'
c_red='\[\e[0;31m\]'
c_green='\[\e[0;32m\]'
c_yellow='\[\e[0;33m\]'
c_blue='\[\e[0;34m\]'
c_magenta='\[\e[0;35m\]'
c_cyan='\[\e[0;36m\]'
c_white='\[\e[0;37m\]'

c_background_black='\[\e[0;40m\]'
c_background_red='\[\e[0;41m\]'
c_background_green='\[\e[0;42m\]'
c_background_yellow='\[\e[0;43m\]'
c_background_blue='\[\e[0;44m\]'
c_background_magenta='\[\e[0;45m\]'
c_background_cyan='\[\e[0;46m\]'
c_background_white='\[\e[0;47m\]'
c_reset='\[\e[0m\]'

# bash version < 4 doesn't doesn't do a couple cool unicode things. this fixes that mostly.
if [ "${BASH_VERSINFO:-0}" -ge 4 ] ; then
  cat_emoji='🐈'
  triangle=$'\uE0B0'
else
  cat_emoji='🐈\[ \]'
  triangle=' '
fi

c_path="$c_black$c_background_blue \w$c_reset$c_blue$triangle$c_reset"
c_git_clean=$c_green
c_git_dirty=$c_red

# PROMPT_COMMAND is run every time the prompt is rendered
# in this case, it sets PS1, the prompt text
# allowing it to update with new information, e.g., the output of git_prompt
PROMPT_COMMAND='PS1="${c_path}$(git_prompt) $ "'

# determines if the git branch you are on is clean or dirty
git_prompt ()
{
  # Is this a git directory?
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi
  # Grab working branch name
  git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  # Clean or dirty branch
  if git diff --quiet 2>/dev/null >&2; then
    git_color=$c_git_clean
  else
    git_color=$c_git_dirty
  fi
  echo " $git_color$git_branch$c_reset"
}

# Colors ls should use for folders, files, symlinks etc, see `man ls` and
# search for LSCOLORS
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex
# Force ls to use colors (G) and use humanized file sizes (h)
alias ls='ls -Gh'

alias gl="git log -2 --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs='git status'
alias gd='git diff'

# python versioning is a nightmare
alias python=python3

# Ask grep always use the color option and show line numbers
export GREP_OPTIONS='--color=auto'

# Set VS Code as the default editor
which -s code && export EDITOR="code --wait"
export PATH="/usr/local/opt/openssl/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
