#!/bin/bash


echo " _      ____  _     _____ _____  ____  _     
/ \__/|/  _ \/ \ /\/    //__ __\/  _ \/ \  /|
| |\/||| / \|| | |||  __\  / \  | / \|| |\ ||
| |  ||| \_/|| \_/|| |     | |  | |-||| | \||
\_/  \|\____/\____/\_/     \_/  \_/ \|\_/  \|
                                             "


echo "Loading this Shit now ..."  


DomainList="$1"


if [ -z "$DomainList" ]; then
  echo "No List?..."
  exit 1
fi

cp path/to/config.ini .
mkdir nmap
mkdir done 

while IFS=$' \t\r\n' read -r domain; do 
  subfinder -d "$domain" > "$domain.1.txt"
  amass enum -d "$domain" -config ./config.ini > "$domain.2.txt"
  sort "$domain.1.txt" "$domain.2.txt" > "$domain"
  nmap -sC -sV -iL "$domain" -oN "$domain.nmap.txt" -v 
  mv "$domain.1.txt" "$domain.2.txt" done/
  mv "$domain.nmap.txt" nmap/
done < "$DomainList"
