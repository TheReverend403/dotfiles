## /etc/profile compatibility
env -i HOME=$HOME dash -l -c 'export -p' | sed -e "/PWD/d; /PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^export/set -x/" | source

if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1 -a -z "$SSH_CONNECTION"
        exec startx > /dev/null ^&1
    end
end

set -gx fish_greeting ''
set -gx fish_color_param default
set -gx fish_color_command default

## Aliases
if test -x $HOME/.config/fish/aliases.fish
    . ~/.config/fish/aliases.fish
end

## Locale
set -gx LANG en_GB.UTF-8
set -gx LC_ALL en_GB.UTF-8

## Default programs
set -gx BROWSER '/usr/bin/firejail firefox'
set -gx EDITOR /usr/bin/vim

## PATH
set path_dirs $HOME/.cargo/bin $HOME/.fzf/bin $HOME/.composer/vendor/bin $HOME/.cargo/bin $HOME/.local/bin $HOME/.gem/ruby/2.1.0/bin $HOME/.gem/ruby/2.0.0/bin /usr/lib/ccache/bin $HOME/.local/bin
for dir in $path_dirs
    # Stop fish complaining if a directory doesn't exist
    if test -x $dir
        set -gx set -gx fish_user_paths $dir $fish_user_paths
    end
end

## XDG
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_DIRS /usr/local/share:/usr/share
set -gx XDG_CONFIG_DIRS /etc/xdg

## Java
set -gx gentoo_user_vm ~/.gentoo/java-config-2/current-user-vm
set -gx JAVA_HOME $gentoo_user_vm
set -gx _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

## Rust racer
set -gx RUST_SRC_PATH /usr/src/rust/src

## NodeJS
set -gx NPM_PACKAGES $HOME/.npm-packages
set -gx NODE_PATH $NPM_PACKAGES/lib/node_modules:$NODE_PATH
set -gx fish_user_paths $NPM_PACKAGES/bin $fish_user_paths

## Less
set -gx LESS '-RSXMsi'
set -gx LESS_TERMCAP_mb (tput bold; tput setaf 2)
set -gx LESS_TERMCAP_md (tput bold; tput setaf 13)
set -gx LESS_TERMCAP_me (tput sgr0)
set -gx LESS_TERMCAP_se (tput rmso; tput sgr0)
set -gx LESS_TERMCAP_us (tput smul; tput bold; tput setaf 7)
set -gx LESS_TERMCAP_ue (tput rmul; tput sgr0)
set -gx LESS_TERMCAP_mr (tput rev)
set -gx LESS_TERMCAP_mh (tput dim)
set -gx LESS_TERMCAP_ZN (tput ssubm)
set -gx LESS_TERMCAP_ZV (tput rsubm)
set -gx LESS_TERMCAP_ZO (tput ssupm)
set -gx LESS_TERMCAP_ZW (tput rsupm)
