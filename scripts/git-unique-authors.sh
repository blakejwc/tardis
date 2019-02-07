#!/bin/bash
git blame --line-porcelain $@ | sed -n 's/^author //p' | sort | uniq | wc -l;
