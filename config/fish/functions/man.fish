function man
    set -x LESS_TERMCAP_mb (tput bold; tput setaf 5)
    set -x LESS_TERMCAP_md (tput bold; tput setaf 5)
    set -x LESS_TERMCAP_me (tput sgr0)
    set -x LESS_TERMCAP_so (tput bold; tput setaf 5; tput setab 0)
    set -x LESS_TERMCAP_se (tput rmso; tput sgr0)
    set -x LESS_TERMCAP_ue (tput rmul; tput sgr0)
    set -x LESS_TERMCAP_us (tput smul; tput bold; tput setaf 7)
    command man $argv
end
