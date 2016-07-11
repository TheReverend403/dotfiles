function myip -d 'Prints your public IP address.'
    set -l ip (dig +short myip.opendns.com @resolver1.opendns.com)
    fish_msg $ip
end
