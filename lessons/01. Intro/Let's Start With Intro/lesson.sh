#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔰 Lesson 01: Introduction to Linux${RESET}"
echo
echo "Welcome to your first lesson!"
echo
echo "💡 Linux is a family of open-source operating systems built around the Linux kernel."
echo "It's widely used in servers, desktops, embedded systems, and especially hacking!"
echo
echo "These are the commands or tools we use in our daily life"
echo "
adduser    alias      apropos    arp        awk        batch      bg         cal        cat        chattr
chgrp      chmod      chown      clear      cmp        crontab    curl       cut        date       deluser
df         dig        dirs       dmesg      dmidecode  du         echo       env        exit       export
fg         file       find       firewall-cmd  free     ftp        gpg        grep       groupadd   groupdel
groupmod   groups     head       hexdump    history    hostname   htop       id         ifconfig   ionice
iptables   ip         journalctl jobs       kill       killall    last       lastlog    ldd        ldconfig
ldd        locate     loginctl   logrotate  logger     lscpu      ls         lsattr     lsblk      lspci
lsusb      man        md5sum     mkdir      mount      mv         nano       netcat     netstat    nice
nmap       nohup      passwd     ping       ping6      pkill      ps         pwd        read       reboot
renice     rm         rsync      scp        sed        seq        service    set        sha256sum  shutdown
sleep      ss         stat       strings    su         sudo       systemctl  tail       tcpdump    tee
telnet     time       top        touch      traceroute traceroute6 trap      type       uname      unalias
unset      uptime     useradd    userdel    usermod    users      visudo     vmstat     wc         wget
what       whatis     whereis    which      who        whoami     xargs      xxd        yes        "
pause

echo
echo -e "📂 Let's try your first command: ${BOLD}pwd${RESET} — it shows the current working directory."
read -p "$ " user_cmd

if [[ "$user_cmd" == "pwd" ]]; then
    echo
    pwd
    success "Nice! You just printed the current directory."
else
    fail "Oops! That wasn't 'pwd'. Try again later!"
fi

pause

echo
echo -e "🧠 Next up: ${BOLD}ls${RESET} — this lists files and folders in the current directory."
echo "Try it yourself:"
read -p "$ " user_ls

if [[ "$user_ls" == "ls" ]]; then
    echo
    ls
    success "Great! You're learning fast!"
else
    fail "Hmm... that wasn't 'ls'. No worries, you'll get it!"
fi

pause

echo
echo -e "📁 Now try: ${BOLD}whoami${RESET} — this shows your current username."
read -p "$ " user_whoami

if [[ "$user_whoami" == "whoami" ]]; then
    echo
    whoami
    success "You're getting the hang of this!"
else
    fail "Not quite! Try using 'whoami' next time."
fi

pause

echo -e "⌚ Next: ${BOLD}date${RESET} — it shows the current date and time."
read -p "$ " user_date

if [[ "$user_date" == "date" ]]; then
    echo
    date
    success "Awesome! That's how you see the current time."
else
    fail "Oops, try 'date' next time."
fi

pause

echo -e "📦 Another one: ${BOLD}uname -a${RESET} — displays system information."
read -p "$ " user_uname

if [[ "$user_uname" == "uname -a" ]]; then
    echo
    uname -a
    success "Cool! Now you know your system info."
else
    fail "Hmm, try 'uname -a' exactly next time."
fi

pause

echo -e "${GREEN}${BOLD}🎉 Congratulations! You've completed Lesson 01.${RESET}"
echo "Next, you can try lessons on commands like ls, cd, ifconfig, and more!"
pause
