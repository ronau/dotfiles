autoload -Uz vcs_info

# VCS info at prompt
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'        # display this when there are unstaged changes (%u)
zstyle ':vcs_info:*' stagedstr '+'          # display this when there are staged changes (%c)
zstyle ':vcs_info:*' formats ' %F{013}[%b]%c%u%f'              # normal VCS info string (color: magenta)
zstyle ':vcs_info:*' actionformats ' %F{013}[%b% (%a)]%c%u%f'  # VCS info string during special action (e.g. merge conflict)
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:%r'  # include revision number for svn and bzr

function precmd () {
  vcs_info

  print -Pn "\e]0;%n@%m: %~\a"   # terminal title: user, host, pwd
}

function preexec() {
  print -Pn "\e]0;($1) %n@%m: %~\a"   # terminal title: (cmd), user, host, pwd
}


setopt prompt_subst
autoload -U promptinit
promptinit




NEWLINE=$'\n'
PROMPT_SYMBOL='❯'

# username@host will be set only if we are in remote ssh session
# username@host will be white font on red ground, if it's a root session
[[ "$SSH_CONNECTION" != '' ]] && USERNAMEHOST='%n@%m '
[[ $UID -eq 0 ]] && USERNAMEHOST='%K{001}%F{015}%n@%m%f%k '

# shell level if deeper than 1 (color: light red)
[[ $SHLVL -gt 1 ]] && SHELL_LEVEL="%F{009}L%B${SHLVL}%b%f "

# screen window (color: gray = light black)
[[ -n $WINDOW ]] && SCREEN_NO="%F{008}screen%B${WINDOW}%b%f "

# prevent breaking the prompt with default venv output
# instead we will add the venv output on our own using a function
export VIRTUAL_ENV_DISABLE_PROMPT=1
function virtualenv_prompt_info(){
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "[${VIRTUAL_ENV:t2}] "
}

#
# PROMPT consists of 3 lines

# 1st line: only newline char, to keep some space
PROMPT='${NEWLINE}'

# 2nd line: username@host (if remote or root session),
#           shell level if deeper than 1
#           screen window number
#           followed by current path (color: yellow),
#           followed by VCS message (see above)
PROMPT+='${USERNAMEHOST}${SHELL_LEVEL}${SCREEN_NO}%F{011}%~%f${vcs_info_msg_0_}${NEWLINE}'

# 3rd line: prompt symbol (defined above), will be colored red if last command exited with non-zero
PROMPT+='$(virtualenv_prompt_info)%(?.${PROMPT_SYMBOL}.%B%F{red}${PROMPT_SYMBOL}%f%b)%f %{$reset_color%}'