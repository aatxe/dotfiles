wd=$(pwd)

# Set up git configurations.
ln -s $wd/gitconfig $HOME/.gitconfig
ln -s $wd/gitignore $HOME/.gitignore
ln -s $wd/git $HOME/.config/git

# Set up ideavimrc.
ln -s $wd/ideavimrc $HOME/.ideavimrc

# Set up chemacs.
git clone https://github.com/plexus/chemacs2.git ~/.emacs.d
ln -s $wd/emacs-profiles.el $HOME/.emacs-profiles.el

# Set up Doom Emacs.
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.doom
~/.emacs.doom/bin/doom install

# Set up spacemacs.
git clone -b develop https://github.com/syl20bnr/spacemacs $HOME/.emacs.spacemacs
ln -s $wd/spacemacs $HOME/.spacemacs
ln -s $wd/layers/* $HOME/.emacs.spacemacs/private/
ln -s $wd/packages/* $HOME/.emacs.spacemacs/private/

# Set up atom.
mkdir $HOME/.atom
ln -s $wd/atom/* $HOME/.atom

# Set up fish.
mkdir -p $HOME/.config/fish/
ln -s $wd/fish/config.fish $HOME/.config/fish/config.fish
ln -s $wd/fish/functions $HOME/.config/fish/functions
fish fish/setup.fish
chsh -s $(which fish)

# Set up gpg-agent.
ln -s $wd/gnupg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
gpgconf --reload gpg-agent
