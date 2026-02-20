#!/bin/bash

is_video() {
  local f="${1,,}"
  case "$f" in
  *.mp4 | *.mkv | *.webm | *.mov | *.avi | *.m4v) return 0 ;;
  *) return 1 ;;
  esac
}

is_video "$1"
