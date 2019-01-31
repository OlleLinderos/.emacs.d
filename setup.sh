#!/bin/bash

MSG_ARRAY=()

basic_setup() {
    if ! [ -x "$(command -v brew)" ]; then
        eval '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
        if [ $? -eq 0 ]; then
            MSG_ARRAY+=("Successfully installed: brew")
        else
            MSG_ARRAY+=("Installation of brew failed")
        fi
    else
        MSG_ARRAY+=("Already installed: brew")
    fi

    if ! [ -x "$(command -v pip)" ]; then
        eval 'sudo easy_install pip'
        if [ $? -eq 0 ]; then
            MSG_ARRAY+=("Successfully installed: pip")
        else
            MSG_ARRAY+=("Installation of pip failed")
        fi
    else
        MSG_ARRAY+=("Already installed: pip")
    fi
}

brew_package() {
    brew list $1
    if [ $? -eq 0 ]; then
        MSG_ARRAY+=("Already installed: $1")
    else
        brew install $1 $2
        if [ $? -eq 0 ]; then
            MSG_ARRAY+=("Successfully installed: $1")
        else
            MSG_ARRAY+=("Installation of $1 failed")
        fi
    fi
}

install_font() {
    brew cask list font-space-mono
    if [ $? -eq 0 ]; then
        MSG_ARRAY+=('Already installed: font-space-mono')
    else
        brew tap homebrew/cask-fonts
        brew cask install font-space-mono
        if [ $? -eq 0 ]; then
            MSG_ARRAY+=('Succesfully installed: font-space-mono')
        else
            MSG_ARRAY+=('Installation of font-space-mono failed')
        fi
    fi
}

setup_results() {
    echo '\nsetup.sh finished with the following results:'
    printf '\ %s\n' "${MSG_ARRAY[@]}"
}

run_setup() {
    basic_setup
    brew_package 'emacs-plus' '--without-spacemacs-icon --with-no-titlebar'
    brew_package 'the_silver_searcher'
    install_font
    setup_results
}

run_setup
