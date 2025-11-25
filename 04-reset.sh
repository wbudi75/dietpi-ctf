#!/bin/bash

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

rm -f /etc/ctf_groupname
rm -f /etc/ctf_flags_generated

for d in "${FLAG_DIRS[@]}"; do
    rm -f "$d/flag.txt"
done

echo "[✓] Semua flag & data kelompok telah dihapus."
