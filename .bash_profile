echo "Logged in as $USER at $(hostname)"

# set tab length to 2 spaces
tabs -2

# Path for brew
test -d /usr/local/bin && export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
# Path for Heroku
test -d /usr/local/heroku/ && export PATH="/usr/local/heroku/bin:$PATH"

# load NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

# Load git completions
git_completion_script=/usr/local/etc/bash_completion.d/git-completion.bash
test -s $git_completion_script && source $git_completion_script

# A more colorful prompt
c_reset='\[\e[0m\]' # default
c_path='\[\e[0;31m\]' # red
c_git_clean='\[\e[0;32m\]' # green
c_git_dirty='\[\e[0;31m\]' # red
cat_emoji='🐈\[  \]' # bash doesn't count the spaces emoji take up correctly. this fixes that.

# PROMPT_COMMAND is run every time the prompt is rendered
# in this case, it sets PS1, the prompt text
# allowing it to update with new information, e.g., the output of git_prompt
PROMPT_COMMAND='PS1="${c_path}\w${c_reset}$(git_prompt) ${cat_emoji}$ "'

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

alias glog='git log --oneline --graph -2'

# Force grep to always use the color option and show line numbers
export GREP_OPTIONS='--color=always'

# Set VS Code as the default editor
which -s code && export EDITOR="code --wait"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias gs='git status'
alias gd='git diff'
