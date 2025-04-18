#!/bin/sh
declare -a parsed_args
for arg in "$@"; do 
  if [ ${arg:0:1} == "-" ]; then
    parsed_args+=("$arg")
  elif [ -f "$arg" ]; then
    parsed_args+=("@@ \"$arg\" @@")
  else
    parsed_args+=("$arg")
  fi
done

eval "flatpak run --file-forwarding com.github.dail8859.NotepadNext ${parsed_args[@]}"
