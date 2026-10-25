# dotfiles

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/68fpjc/dotfiles/master/install.sh)"
```

The installer installs the asdf `v0.20.2` binary in `~/.local/bin` and keeps
plugin and shim data in `~/.asdf`. It supports Linux x86_64, ARM64, and 32-bit
x86.

## WSL2 SSH agent

Before running the installer in WSL, make sure `~/winhome` exists and points
to your Windows home directory. For example:

```sh
ln -s /mnt/c/Users/<WindowsUser> ~/winhome
```

On WSL2, `install.sh` installs `socat` if needed and downloads the
[`wsl-ssh-agent-relay`](https://github.com/rupor-github/wsl-ssh-agent/blob/master/docs/wsl-ssh-agent-relay)
helper to `~/.local/bin`. The helper expects `npiperelay.exe` at
`~/winhome/.wsl/npiperelay.exe`, where `~/winhome` is the Windows home link
provided before running the installer. If the legacy Scoop installation is
present, the installer copies `npiperelay.exe` from there automatically.
Otherwise, place it in the expected location before starting a shell.

If it is installed elsewhere, copy it into the expected location manually:

```sh
mkdir -p ~/winhome/.wsl
cp ~/winhome/scoop/apps/wsl-ssh-agent/current/npiperelay.exe ~/winhome/.wsl/
```
