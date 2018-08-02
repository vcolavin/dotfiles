echo "$USER logged in at $(hostname), bub"

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

# A more colorful prompt
c_reset='\[\e[0m\]' # default
c_path='\[\e[0;31m\]' # red
c_git_clean='\[\e[0;32m\]' # green
c_git_dirty='\[\e[0;31m\]' # red
cat_emoji='🐈\[ \]' # bash doesn't count the emoji columns correctly. this fixes that mostly.

# PROMPT_COMMAND is run every time the prompt is rendered
# in this case, it sets PS1, the prompt text
# allowing it to update with new information, e.g., the output of git_prompt
PROMPT_COMMAND='PS1="${c_path}\w${c_reset}$(git_prompt) ${cat_emoji} $ "'

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
    git_color="${c_git_clean}"
  else
    git_color=${c_git_dirty}
  fi
  echo " [$git_color$git_branch${c_reset}]"
}

# Colors ls should use for folders, files, symlinks etc, see `man ls` and
# search for LSCOLORS
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex
# Force ls to use colors (G) and use humanized file sizes (h)
alias ls='ls -Gh'

alias gl="git log -2 --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs='git status'
alias gd='git diff'

# Ask grep always use the color option and show line numbers
export GREP_OPTIONS='--color=auto'

# Set VS Code as the default editor
which -s code && export EDITOR="code --wait"
export PATH="/usr/local/opt/openssl/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
