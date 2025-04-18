#!/bin/bash
if [ -z "$ZDOTDIR" ]; then 
  echo "ERROR: env ZDOTDIR is not set"
  exit 1
fi
shopt -s dotglob
for f in ./zsh-home/*; do
  if [ ! -f "$f" ]; then
    echo "Skipped invalid file '$f'"
    continue;
  fi
  filepath=$(realpath "$f")
  basename=$(basename "$f")
  ln -s "$filepath" "$ZDOTDIR/$basename"
  if [ $? -eq 0 ]; then 
    echo "Created '$basename' link in $ZDOTDIR"
  fi
done
shopt -u dotglob
