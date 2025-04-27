alias vim="/opt/homebrew/bin/nvim"
alias ll="ls -al"

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(/opt/homebrew/bin/brew shellenv)"

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
