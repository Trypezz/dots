#!/bin/bash

pretty_name() {
  local p="$1"
  local n
  n="$(basename -- "$p")"
  printf '%s' "$n"
}

pretty_name "$1"
