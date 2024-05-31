# dotfiles

## Fish

### Requirements
- bat (https://github.com/sharkdp/bat)
- exa (https://the.exa.website/install/linux)
- fish (https://fishshell.com/)

### Installation



#### Change terminal
    which fish

*/usr/bin/fish*

    chsh user -s /usr/bin/fish
    set -U fish_user_paths $fish_user_paths ~/.local/bin

*Reload terminal*

#### Install fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

#### Install plugins
    fisher install PatrickF1/fzf.fish
    fisher install jethrokuan/z
    fisher install jorgebucaran/autopair.fish

#### Copy fish settings
    cp dotfiles/fish/config.fish ~/.config/fish

*Reload terminal*

## Neovim

### Requirements
- python3
- python3-dotenv
- npm

### Installation
*On Linux*

#### Download tar.gz
https://github.com/neovim/neovim/blob/master/INSTALL.md

#### Copy binaries
    sudo cp -r nvim-linux64/bin/* /usr/local/bin/
    sudo cp -r nvim-linux64/lib/* /usr/local/lib/
    sudo cp -r nvim-linux64/share/* /usr/local/share/

#### Copy neovim settings
    cp dotfiles/nvim ~/.config/
    neovim

*This will install the plugins*


