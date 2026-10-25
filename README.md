# dotfiles

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/68fpjc/dotfiles/master/install.sh)"
```

## WSL2 SSH agent

On WSL2, `install.sh` installs `socat` if needed and downloads the
[`wsl-ssh-agent-relay`](https://github.com/rupor-github/wsl-ssh-agent/blob/master/docs/wsl-ssh-agent-relay)
helper to `~/.local/bin`. The helper expects `npiperelay.exe` at
`~/winhome/.wsl/npiperelay.exe`, where `~/winhome` is the Windows home link
created by the installer. If the legacy Scoop installation is present, the
installer copies `npiperelay.exe` from there automatically. Otherwise, place it
in the expected location before starting a shell.

If it is installed elsewhere, copy it into the expected location manually:

```sh
mkdir -p ~/winhome/.wsl
cp ~/winhome/scoop/apps/wsl-ssh-agent/current/npiperelay.exe ~/winhome/.wsl/
```
