#!/usr/bin/env python2.7
"""
This script will echo each line in either stdin or a given file,
with a 1/50th of a second delay between each. This makes it
suitable for "playing" the animations found on textfiles.com:
    http://artscene.textfiles.com/vt100/
Just use it like this:
    $ ./vtecho.py somefilename.txt
    
Or this:
    $ curl -s http://artscene.textfiles.com/vt100/frogs.vt | ./vtecho.py
"""

from sys import argv, stdout, stdin
from time import sleep

lines = []

# are we using stdin or a file?
if len(argv) > 1:
    lines = open(argv[1], 'r').readlines()
else:
    lines = stdin

# clear the screen
stdout.write('\x1b[0;m\x1b[2J\x1b[0;0H')

# read/echo/sleep
for line in lines:
    stdout.write(line)
    stdout.flush()
    sleep(0.05)