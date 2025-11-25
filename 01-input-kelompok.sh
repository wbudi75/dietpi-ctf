#!/bin/bash

# Jika sudah pernah input, keluar
if [ -f /etc/ctf_flags_generated ]; then
    exit 0
fi

echo ""
echo "======================================"
echo "     INPUT NAMA KELOMPOK UNTUK CTF"
echo "======================================"
read -p "Masukkan Nama Kelompok: " GROUP

echo "$GROUP" > /etc/ctf_groupname
touch /etc/ctf_flags_generated

echo "[✓] Nama kelompok disimpan: $GROUP"
