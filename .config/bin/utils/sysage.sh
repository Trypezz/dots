#!/bin/bash

birth=$(stat -c %W /)
[ "$birth" -le 0 ] && birth=$(stat -c %Y /)
echo "$(date -d @$birth +%d.%m.%Y) [$((($(date +%s) - birth) / 86400)) Days]"
