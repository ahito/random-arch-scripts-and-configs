#!/bin/bash
for f in ./profile.d/*.sh; do
  filepath=$(realpath "$f")
  basename=$(basename "$f")
  ln -s "$filepath" "/etc/profile.d/$basename";
  if [ $? -eq 0 ]; then
    echo "Created '$basename' link in /etc/profile.d"
  fi
done
unset f
