#!/bin/bash

for f in ./flatpak-app-scripts/*.sh; do
  if [ ! -f "$f" ]; then
    echo "Skipped invalid file '$f'"
    continue;
  fi
  filepath=$(realpath "$f")
  basename=$(basename "$f")
  ln -s "$filepath" "$HOME/.local/bin/${basename%.sh}"
  if [ $? -eq 0 ]; then 
    echo "Created '${basename%.sh}' link in $HOME/.local/bin"
  fi
done

