function man
    set -x LESS_TERMCAP_mb (printf "\e[1;31m")
    set -x LESS_TERMCAP_md (printf "\e[1;31m")
    set -x LESS_TERMCAP_me (printf "\e[0m")
    set -x LESS_TERMCAP_se (printf "\e[0m")
    set -x LESS_TERMCAP_so (printf "\e[1;44;33m")
    set -x LESS_TERMCAP_ue (printf "\e[0m")
    set -x LESS_TERMCAP_us (printf "\e[1;32m")
    command man $argv
end
