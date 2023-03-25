[ -f "${HOME}/.profile" ] && . "${HOME}/.profile"

uname -r | grep -q -i microsoft
if [ $? -eq 0 ]; then
    if [ -d /run/WSL/ ]; then # WSL2
        # export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
        if [ -n "${USERPROFILE}" ]; then
            export SSH_AUTH_SOCK=${HOME}/.ssh/agent.sock
            ss -a | grep -q "${SSH_AUTH_SOCK}"
            if [ $? -ne 0 ]; then
                rm -f "${SSH_AUTH_SOCK}"
                (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"${HOME}/winhome/scoop/apps/wsl-ssh-agent/current/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
            fi
        fi
    else # WSL
        # export DISPLAY=:0
        [ -n "${WSL_AUTH_SOCK}" ] && export SSH_AUTH_SOCK=${WSL_AUTH_SOCK}
    fi
fi
