[ -f "$HOME/.profile" ] && . "$HOME/.profile"

if [ ! -d /home/linuxbrew/.linuxbrew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

[ -d $HOME/.ssh ] || mkdir $HOME/.ssh && chmod 700 $HOME/.ssh

uname -r | grep -q -i microsoft
if [ $? -eq 0 ]; then
    if [ "$USERPROFILE" != "" ]; then
        [ -L $HOME/winhome ] || ln -s $USERPROFILE $HOME/winhome
        which socat > /dev/null; [ $? -ne 0 ] && brew install patchelf && brew install socat
        export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
        ss -a | grep -q $SSH_AUTH_SOCK
        if [ $? -ne 0 ]; then
            rm -f $SSH_AUTH_SOCK
            ( setsid /home/linuxbrew/.linuxbrew/bin/socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$HOME/winhome/.wsl/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork & ) >/dev/null 2>&1
        fi
        export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
    else
        echo USERPROFILE not defined.
    fi
fi

which nvim > /dev/null; [ $? -ne 0 ] && brew install neovim
export EDITOR=nvim
export VISUAL=nvim
