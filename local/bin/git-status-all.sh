#!/bin/sh

for d in */ ; do
    if [ ! -d $d/.git ]
    then
        echo -e "\033[0;31m$d is not under git\033[0m"
    else
        cd $d
        GIT_STATUS=$(git status -s)
        cd ..

        if [ "x$GIT_STATUS" == "x" ]
        then
            echo -e "\033[0;34m$d is under git and up-to-date\033[0m"
        else
            echo -e "\033[0;33m$d is under git and has changes\033[0m"
        fi
    fi
done
