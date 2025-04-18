#!/bin/sh

for f in ./zsh-etc/*; do
  if [ ! -f "$f" ]; then
    echo "Skipped invalid file '$f'"
    continue;
  fi
  filepath=$(realpath "$f")
  basename=$(basename "$f")
  ln -s "$filepath" "/etc/zsh/$basename"
  if [ $? -eq 0 ]; then 
    echo "Created '$basename' link in /etc/zsh"
  fi
done
