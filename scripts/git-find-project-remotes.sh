#! /bin/bash

function find-project-remotes {
    for entry in `find -iname *.git`
    do
        url=$(cd ${entry%.git}; git config --get remote.origin.url)
        status=$(cd ${entry%.git}; git status -s)
        if [ -z "$status" ]; then
            status="\e[0;32mCLEAN\e[0;39m"
        else
            status="\e[0;31mDIRTY\e[0;39m"
        fi
        echo -e "$status    $entry    $url"
    done
}

find-project-remotes | column -t