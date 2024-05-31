# dotfiles

## Fish

### Requirements
- bat
- exa

### Installation

#### Install fish
    https://fishshell.com/
    which fish
    chsh user -s /usr/bin/fish
    set -U fish_user_paths $fish_user_paths ~/.local/bin

*Reload terminal*

#### Install fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

#### Install plugins
    fisher install PatrickF1/fzf.fish
    fisher install jethrokuan/z
    fisher install jorgebucaran/autopair.fish

#### Clone repository
    git https://github.com/dudujunior12/dotfiles.git
    cd dotfiles
    cp fish/config.fish ~/.config/fish

*Reload terminal*
