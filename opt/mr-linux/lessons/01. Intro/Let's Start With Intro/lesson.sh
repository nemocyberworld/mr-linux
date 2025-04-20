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
ls        cd        pwd       mkdir     rm        cp        mv        touch     cat       nano
vim       top       htop      df        du        free      uname     whoami    uptime    ping
ifconfig  ip        netstat   ss        dig       traceroute wget     curl      scp       rsync
chmod     chown     locate    find      grep      awk       sed       echo      read      history
clear     man       alias     unalias   exit      shutdown  reboot    ps        kill      xargs
killall   nice      renice    watch     nohup     jobs      fg        bg        basename  dirname
stat      file      tee       head      tail      cut       sort      uniq      diff      cmp
wc        yes       expr      test      bc        seq       sleep     time      cal       date
logger    dmesg     mount     umount    lsblk     blkid     fdisk     parted    mkfs      fsck
lsof      strace    ldd       env       export    unset     set       printenv  crontab   at
batch     systemctl service   journalctl init      telinit   runlevel  hostname  hostnamectl lsmod
modprobe  rmmod     insmod    dmidecode lscpu     lsusb     lspci     users     groups    id
passwd    adduser   useradd   deluser   userdel   usermod   groupadd  groupdel  groupmod  su
sudo      visudo    which     whereis   type      apropos   whatis    lsattr    chattr    ionice
tput      reset     wall      write     mesg      who       w         last      lastlog   loginctl
runuser   nologin   sync      mountpoint findmnt  swapon    swapoff   mkswap    lsns      ipcs
ipcrm     pgrep     pkill     trap      ulimit    vmstat    iostat    iotop     sar       nmon
tload     glances   ncdu      bmon      iftop     vnstat    ethtool   tcpdump   nmap      arp
route     iproute2  netcat    traceroute6 ping6    sshd      sftp      ftp       telnet    nfsstat
showmount rpcinfo   rsyslogd  logrotate auditctl  ausearch  getfacl   setfacl   getsebool setsebool
semanage  restorecon chcon    getenforce setenforce firewalld firewall-cmd iptables ip6tables nft
ufw       fail2ban-client fail2ban-server tcpkill  arping    tc        tcptraceroute mtr   dig+trace whois
host      dnsutils  curl -I   openssl   gpg       sha256sum md5sum    cksum     cmp       hexdump
xxd       strings   filefrag
"
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
