#! /bin/sh

cd
[ -d dotfiles ] || git clone https://github.com/68fpjc/dotfiles.git && sed -i 's|https://github.com/|git@github.com:|' dotfiles/.git/config
find dotfiles -maxdepth 1 -name '.*' -not -name '.' -not -name '.git' | while read A; do
  B=$(basename $A)
  [ -f $B -o -d $B ] && rm -fr $B
  ln -s $A $B
done

if [ ! -d /home/linuxbrew/.linuxbrew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

[ -d .ssh ] || mkdir .ssh && chmod 700 .ssh
uname -r | grep -q -i microsoft
if [ $? -eq 0 ]; then
    if [ "$USERPROFILE" != "" ]; then
        [ -L winhome ] || ln -s $USERPROFILE winhome
        which socat > /dev/null; [ $? -ne 0 ] && brew install patchelf && brew install socat
    else
        echo WARNING: Define USERPROFILE and try again.
    fi
fi

which nvim > /dev/null; [ $? -ne 0 ] && brew install neovim
