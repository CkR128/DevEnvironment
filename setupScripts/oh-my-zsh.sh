ZSHRC_PATH="$HOME/.zshrc"
rm -frd "$HOME/.oh-my-zsh"
echo "Installing oh my zsh."

zshrc=""
if [[ -f "$HOME/.zshrc" ]]; then
    zshrc=$(<"$ZSHRC_PATH")
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
if [[ zshrc != "" ]]; then
    echo "$zshrc" > "$ZSHRC_PATH"
    rm "$HOME/.zshrc.pre-oh-my"*
    echo "Kept old .zshrc config. Make sure your .zshrc contains the following minimal configuration" 
    echo "----------------------------------------"
    echo 'export ZSH="$HOME/.oh-my-zsh"'
    echo 'ZSH_THEME="robbyrussell"'
    echo "plugins=(git)"
    echo ""
    echo 'source $ZSH/oh-my-zsh.sh'
    echo "----------------------------------------"
    echo ""
fi

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
echo "Cloning p10k ohMyZSH theme."
git clone https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

echo "Cloning ohMyZSH plugins."
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

