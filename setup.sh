#!/bin/bash

if ! [ -x "$(command -v brew)" ]; then
    eval '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
fi

if ! [ -x "$(command -v pip)" ]; then
    eval 'sudo easy_install pip'
fi


# install tern, lein etc
