#! /bin/sh

if [ -d dotfiles ]; then
    cd dotfiles/
    git fetch
    git merge
    cd ../
else
    git clone https://github.com/68fpjc/dotfiles.git
    sed -i 's|https://github.com/|git@github.com:|' dotfiles/.git/config
fi

PROCESSOR=$(uname -m)
for FILE in .bash_aliases .bash_logout .bash_profile .bashrc; do
    [ -f dotfiles/orig/${FILE} ] || touch dotfiles/orig/${FILE}
    if [ ! -h ${FILE} ]; then
        [ -f ${FILE} ] && mv -f ${FILE} dotfiles/orig/
        if [ -f dotfiles/${FILE}.${PROCESSOR} ]; then
            SUFFIX=.${PROCESSOR}
        else
            unset SUFFIX
        fi
        ln -s dotfiles/${FILE}${SUFFIX} ${FILE}
    fi
done

case "${PROCESSOR}" in
    "armv7l")
        which nvim > /dev/null; [ $? -ne 0 ] && sudo apt install -y --no-install-recommends neovim
        ;;
    *)
        if [ ! -d /home/linuxbrew/.linuxbrew ]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        fi
        eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        which nvim > /dev/null; [ $? -ne 0 ] && brew install neovim
        ;;
esac

[ -d .ssh ] || mkdir .ssh && chmod 700 .ssh
uname -r | grep -q -i microsoft
if [ $? -eq 0 ]; then
    if [ "$USERPROFILE" != "" ]; then
        [ -L winhome ] || ln -s $USERPROFILE winhome
        which socat > /dev/null; [ $? -ne 0 ] && brew install patchelf && brew install socat
    else
        echo ERROR: Define USERPROFILE and try again.
        exit 1
    fi
fi

exec $SHELL -l

