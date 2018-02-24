# Load and run compinit (with -i all insecure files and directories will be ignored)
autoload -U compinit
compinit -i

# should be switched on by default already
setopt auto_list        # show list with autocomplete matches (not yet navigable)
setopt auto_menu        # after additional TAB press, navigate through completion matches

unsetopt menu_complete  # Do not autoselect the first completion entry (should be off by default)
setopt complete_in_word

unsetopt flowcontrol    # output flow control via start/stop characters (usually assigned to ^S/^Q) disabled
setopt always_to_end    # after completion, cursor is moved to the end of the word (does not seem to make a difference)


zmodload -i zsh/complist


# Completion System Configuration
# see section 20.3 Completion System Configuration of documentation
# context string always follows this pattern:
#     :completion:function:completer:command:argument:tag

# applies to everything
#zstyle ':completion:*' list-colors ''                  # enabled colored completion lists (use default settings)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}   # enabled colored completion lists (use LS_COLORS settings)
zstyle ':completion:*' menu select search               # menu selection enabled, search enabled
zstyle ':completion:*' verbose yes                      # more verbose completion listing
zstyle ':completion:*' use-cache yes                    # completion caching, use rehash to clear
zstyle ':completion:*' cache-path $ZSH/cache

# set match specifications to be applied everywhere
# 'm:{a-zA-Z}={A-Za-z}'  -> case-insensitive matching
# 'r:|[._-]=* r:|=*'     -> partial-word matching (i.e. everything with ._-/ on the right)
# 'l:|=* r:|=*'          -> substring matching (i.e. everything with everything on the left or right)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# define order for directory completion, do not complete named directories
zstyle ':completion:*:*:cd:*:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# completion for processes and kill command
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'


# ssh autocompletion stuff removed
# seems to work out of the box already


# Don't complete uninteresting users
zstyle ':completion:*:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs
# ... unless we really want to.
zstyle ':completion:*' single-ignored show


# This will show red dots while waiting for expansion/completion
expand-or-complete-with-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots   # Ctrl-I = Tab

