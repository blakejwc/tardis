#! /bin/bash
git config --global --get-regexp alias | grep -i "$1" | awk -v nr=2 '{sub(/^alias\./,"")};{printf "\033[31m%10s\033[1;37m", $1};{sep=FS};{for (x=nr; x<=NF; x++) {printf "%s%s", sep, $x; }; print "\033[0;39m"}'