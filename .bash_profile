[ -f "${HOME}/.profile" ] && . "${HOME}/.profile"
export PATH="${HOME}/.local/bin:${ASDF_DATA_DIR:-${HOME}/.asdf}/shims:${PATH}"

uname -r | grep -q -i microsoft
if [ $? -eq 0 ]; then
    if [ -d /run/WSL/ ]; then # WSL2
        # export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
        "${HOME}/.local/bin/wsl-ssh-agent-relay" start
        export SSH_AUTH_SOCK="${HOME}/.ssh/wsl-ssh-agent.sock"
    else # WSL
        # export DISPLAY=:0
        [ -n "${WSL_AUTH_SOCK}" ] && export SSH_AUTH_SOCK=${WSL_AUTH_SOCK}
    fi
fi
