wd=$(pwd)

# Set up git configurations.
ln -s $wd/gitconfig $HOME/.gitconfig
ln -s $wd/gitignore $HOME/.gitignore

# Set up spacemacs.
git clone -b develop https://github.com/syl20bnr/spacemacs $HOME/.emacs.d
ln -s $wd/spacemacs $HOME/.spacemacs
ln -s $wd/layers/* $HOME/.emacs.d/private/
ln -s $wd/packages/* $HOME/.emacs.d/private/

# Set up zsh with oh-my-zsh.
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
ln -s $wd/zshrc $HOME/.zshrc
ln -s $wd/zsh/*.zsh $ZSH/custom/
mkdir $ZSH/custom/themes
ln -s $wd/zsh/themes/*.zsh-theme $ZSH/custom/themes/
chsh -s /bin/zsh

# Set up gpg-agent.
ln -s $wd/gnupg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
gpgconf --reload gpg-agent
