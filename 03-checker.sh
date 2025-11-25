#!/bin/bash

GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

FLAG_DIRS=(
  "/srv/ftp"
  "/var/www/html"
  "/srv/samba/share1"
  "/srv/samba/share2"
  "/etc/flags"
  "/opt/app1"
  "/opt/app2"
  "/var/log/flags"
  "/usr/local/share/flags"
  "/home/ctf"
)

echo "====== CHECKER CTF ======"
echo ""

# Cek nama kelompok
if [ -f /etc/ctf_groupname ]; then
    echo -e "${GREEN}[PASS]${NC} Nama kelompok: $(cat /etc/ctf_groupname)"
else
    echo -e "${RED}[FAIL]${NC} Nama kelompok belum diinput"
fi

echo ""

# Cek folder dan flag
for d in "${FLAG_DIRS[@]}"; do
    if [ -d "$d" ]; then
        echo -e "${GREEN}[FOLDER OK]${NC} $d"
    else
        echo -e "${RED}[FOLDER MISSING]${NC} $d"
        continue
    fi

    if [ -f "$d/flag.txt" ]; then
        echo -e "   ${GREEN}[FLAG OK]${NC} $d/flag.txt"
    else
        echo -e "   ${RED}[FLAG MISSING]${NC} $d/flag.txt"
    fi
done

echo ""
echo "====== CHECK SELESAI ======"
