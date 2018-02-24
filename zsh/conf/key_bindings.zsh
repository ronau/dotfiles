# Here be dragons!!!
#
# https://en.wikipedia.org/wiki/ANSI_escape_code
# https://en.wikipedia.org/wiki/Control_character
#
# Special keys on keyboard are mapped by so called escape sequences.
# They are usually introduced by the ESC key.
#
# To write down those escape sequences, several notations could used.
# One is the Ctrl-Key notation, because on old terminals the control key generates
# the code 64 places below the code for the (generally) uppercase letter is is pressed with
# (i.e. subtract 64 from ASCII code value in decimal).
# So Ctrl+[ would result in the ESC key ("[" is ASCII 91, ESC is ASCII 27).
#
# In printable form the Ctrl key is often written as caret symbol (^).
# That is, here the string "^[" refers to Ctrl+[ which is actually the ESC key.

bindkey -e        # switches on typical Emacs key bindings (e.g. Ctrl-A for beginning of line, Ctrl-E for end of line)

bindkey '^r' history-incremental-search-backward    # Ctrl-R for history search
bindkey '^[w' kill-region                           # Deletes whole line
bindkey "^[m" copy-prev-shell-word                  # Copy previous word, great when renaming files
bindkey ' ' magic-space                             # Also do history expansion on space (not fully clear)



# Special keys are mostly defined as so called Control Sequence Introducer (CSI).
# The sequence for this is ESC [, that's why many of these sequences defined below
# start with "^[[".
#
# Some overview can be found here: http://invisible-island.net/xterm/ctlseqs/ctlseqs.html
#
# Modifiers: parameters are placed before the final(!) character
#
#     Code     Modifiers
#   ---------+---------------------------
#      2     | Shift
#      3     | Alt
#      4     | Shift + Alt
#      5     | Control
#      6     | Shift + Control
#      7     | Alt + Control
#      8     | Shift + Alt + Control
#      9     | Meta
#      10    | Meta + Shift
#      11    | Meta + Alt
#      12    | Meta + Alt + Shift
#      13    | Meta + Ctrl
#      14    | Meta + Ctrl + Shift
#      15    | Meta + Ctrl + Alt
#      16    | Meta + Ctrl + Alt + Shift
#   ---------+---------------------------
#
#     For example, shift-up would be sent as CSI 2A


# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search      # CSI A, i.e. Cursor up
bindkey '^[[B' down-line-or-search    # CSI B, i.e. Cursor down
bindkey "^[[H" beginning-of-line      # CSI H, PC-style sequence for Home key
bindkey "^[[F"  end-of-line           # CSI F, PC-style sequence for End key
bindkey "^[[3~" delete-char           # CSI 3 ~, delete key
bindkey '^[[Z' reverse-menu-complete  # backwards Tab (Shift-Tab) will jump backwards in completion




# Probably obsolete

#bindkey -M menuselect '^o' accept-and-infer-next-history

#bindkey "^[[1~" beginning-of-line     # VT220-style sequence for Home key
#bindkey "^[[4~" end-of-line           # VT220-style sequence for End key
#bindkey "^[[1;5C" forward-word        # Ctrl-Left
#bindkey "^[[1;5D" backward-word       # Ctrl-Right
#bindkey '^?' backward-delete-char     # Backspace
#bindkey "^[[5~" up-line-or-history    # PageUp
#bindkey "^[[6~" down-line-or-history  # PageDown


