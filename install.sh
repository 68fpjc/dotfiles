#! /bin/sh

cd

sudo apt update
which git >/dev/null || sudo apt install -y --no-install-recommends git

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

which nvim >/dev/null; [ $? -ne 0 ] && sudo apt install -y --no-install-recommends neovim

[ -d .ssh ] || mkdir .ssh && chmod 700 .ssh
uname -r | grep -q -i microsoft
if [ $? -eq 0 ]; then
    if [ -n "${USERPROFILE}" ]; then
        [ -L winhome ] || ln -s "${USERPROFILE}" winhome
    else
        echo ERROR: Define USERPROFILE and try again.
        exit 1
    fi
    which socat >/dev/null; [ $? -ne 0 ] && sudo apt install -y --no-install-recommends patchelf socat
fi

git clone https://github.com/asdf-vm/asdf.git .asdf/ --branch v0.14.0
cd .asdf/
git switch -c v0.14.0
cd ..

exec $SHELL -l
