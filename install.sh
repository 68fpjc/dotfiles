#! /bin/sh

cd
# [ -d dotfiles ] || git clone https://github.com/68fpjc/dotfiles.git
find dotfiles -maxdepth 1 -name '.*' -not -name '.' -not -name '.git' | while read A; do
  B=$(basename $A)
  [ -f $B -o -d $B ] && rm -fr $B
  ln -s $A $B
done
