[ -f "$HOME/.profile" ] && . "$HOME/.profile"

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

uname -r | grep -q -i microsoft
if [ $? -eq 0 ]; then
    if [ "$USERPROFILE" != "" ]; then
        export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
        ss -a | grep -q $SSH_AUTH_SOCK
        if [ $? -ne 0 ]; then
            rm -f $SSH_AUTH_SOCK
            ( setsid /home/linuxbrew/.linuxbrew/bin/socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$HOME/winhome/.wsl/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork & ) >/dev/null 2>&1
        fi
        export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
    fi
fi

export EDITOR=nvim
export VISUAL=nvim

