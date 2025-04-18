#!/bin/bash

curscript=$(realpath "$0")

for f in ./install-*.sh; do
  filepath=$(realpath "$f")
  if [ "$filepath" == "$curscript" ]; then
    continue
  fi
  if [ ! -f "$f" ]; then
    echo "Skipping invalid file '$f'"
    continue
  fi
  echo "Running '$f'"
  source $filepath
done

