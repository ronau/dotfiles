#setopt no_beep              # disable beeps
setopt no_list_beep         # disable beeps for ambigous autocompletion only
setopt multios              # allow more than one inputs or output redirects

setopt auto_cd              # cd into directories by just typing the dirname
setopt cd_able_vars         # when cd'ing, zsh will try to find parameter if no matching directory was found
setopt auto_name_dirs       # any parameter which refers to a directory will automatically be turned into a name

setopt auto_pushd           # any directory changing will also pushd to directory stack
setopt pushd_ignore_dups    # remove duplicate entries from pushd directory stack

setopt long_list_jobs       # list jobs in long format by default



# Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history             # append to history file instead of replacing it
setopt inc_append_history         # append command to history file immediately
setopt share_history              # constantly reload history, i.e. share history data across multiple instances
setopt extended_history           # save additional info to history file
setopt hist_expire_dups_first     # when trimming history file, first drop commands that have duplicates
setopt hist_ignore_dups           # do not add command to history list if it's duplicate of previous
setopt hist_ignore_space          # if commandline starts with whitespace, don't add it to history
setopt hist_verify                # don't execute from history directly, but instead expand and load the line



# Smart handling of URLs (and special characters in it)
# see https://www.zsh.org/mla/workers/2015/msg02221.html
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
#zstyle :bracketed-paste-magic paste-init backward-extend-paste

# Jump through paths one path component at a time (like bash)
# alternatively, this can be defined, too: WORDCHARS=''
autoload -U select-word-style
select-word-style bash

# Editing of command line in preferred editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line     # Ctrl-x e (emacs style)
bindkey '^x^e' edit-command-line    # Ctrl-x Ctrl-e (emacs style)
bindkey '^[v' edit-command-line     # ESC v (vi style)


# Defaults
export PAGER=less
export EDITOR=vim
export TERM=xterm-256color          # useful to override TERM being set to "screen" by screen program (which would disable colors)
export LC_CTYPE=en_US.UTF-8