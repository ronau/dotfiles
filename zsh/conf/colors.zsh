# Default ls colors
# ----------------------
# BSD (and macOS) ls uses LSCOLORS (if "ls -G" is run or "export CLICOLORS=1" is set)
# Linux ls uses LS_COLORS (for "ls --color")
# Both have different "syntax".
# see generator here: https://geoff.greer.fm/lscolors/ (or https://github.com/ggreer/lscolors)
# or read here: https://gist.github.com/thomd/7667642
#
# These should be the defaults, so uncomment only if different style should be applied
#export LSCOLORS="exfxcxdxbxegedabagacad"
#export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# we set a slightly different LS_COLORS here
# (without ;40 background, which is black, for di, ln, etc.)
# (with 0 instead of 30 as foreground for su, sg, etc.)
# this color setting will be referred to in the list completion settings
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43"

# Enable ls colors
if [ "$DISABLE_LS_COLORS" != "true" ]
then
  # Find the option for using colors in ls, depending on the version: Linux or BSD
  ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi




# load basic eight-color terminal codes
# see http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Other-Functions
autoload colors; colors;


# Set display attributes (the arrays FX, FG and BG) for 256 colors
#   flag -A indicates associate arrays
#   flag -g (global) will not restrict attributes to local scope
typeset -Ag FX FG BG

# ANSI escape codes
# see https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_(Select_Graphic_Rendition)_parameters

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done


# Show all 256 colors with color number
function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}