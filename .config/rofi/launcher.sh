#!/bin/bash

dir="$HOME/.config/rofi/"
mode="$1"
menu="$2"

## Run
rofi \
  -${mode} \
  -theme ${dir}/${menu}.rasi
