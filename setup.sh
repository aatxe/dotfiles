wd=$(pwd)

# Set up git configurations.
ln -s $wd/gitconfig $HOME/.gitconfig
ln -s $wd/gitignore $HOME/.gitignore
ln -s $wd/git $HOME/.config/git

# Set up ideavimrc.
ln -s $wd/ideavimrc $HOME/.ideavimrc

# Set up spacemacs.
git clone -b develop https://github.com/syl20bnr/spacemacs $HOME/.emacs.d
ln -s $wd/spacemacs $HOME/.spacemacs
ln -s $wd/layers/* $HOME/.emacs.d/private/
ln -s $wd/packages/* $HOME/.emacs.d/private/

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
