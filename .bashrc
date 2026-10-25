. ${HOME}/dotfiles/orig/.bashrc

export EDITOR=vim

if command -v asdf >/dev/null 2>&1; then
    . <(asdf completion bash)
fi
