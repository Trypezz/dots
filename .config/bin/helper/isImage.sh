#!/bin/bash

is_image() {
  local f="${1,,}"
  case "$f" in
  *.png | *.jpg | *.jpeg | *.webp | *.bmp | *.tiff | *.gif) return 0 ;;
  *) return 1 ;;
  esac
}

is_image "$1"
