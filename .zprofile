alias vim="/opt/homebrew/bin/nvim"
alias ll="ls -al"

eval "$(/opt/homebrew/bin/brew shellenv)"


eval "$(/opt/homebrew/bin/brew shellenv)"

##
# Your previous /Users/cameron/.zprofile file was backed up as /Users/cameron/.zprofile.macports-saved_2022-11-15_at_18:59:40
##

# MacPorts Installer addition on 2022-11-15_at_18:59:40: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# MacPorts Installer addition on 2022-11-15_at_18:59:40: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH="/opt/local/share/man:$MANPATH"
# Finished adapting your MANPATH environment variable for use with MacPorts.

# Created by `pipx` on 2025-02-07 03:04:10
export PATH="$PATH:/Users/cameron/.local/bin"

addToPath() {
	if [[ "$PATH" != *"$1"* ]]; then
		export PATH=$PATH:$1
	fi
}

addToPath $HOME/.local/scripts

tmux-sessionizer() {
	source /Users/cameron/.local/scripts/tmux-sessionizer
}
zle -N tmux-sessionizer

bindkey '^f' tmux-sessionizer
