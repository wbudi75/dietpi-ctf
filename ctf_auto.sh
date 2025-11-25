#!/bin/bash

# Jangan tampilkan prompt lagi jika flag sudah dibuat
if [ -f /etc/ctf_flags_generated ]; then
    return
fi

# --- STEP 1: INPUT NAMA KELOMPOK ---
echo ""
echo "======================================"
echo "     INPUT NAMA KELOMPOK UNTUK CTF"
echo "======================================"
read -p "Masukkan Nama Kelompok: " GROUP

echo "$GROUP" > /etc/ctf_groupname
touch /etc/ctf_flags_generated

# --- STEP 2: GENERATE FLAG ---
/usr/local/bin/02-generate-flags.sh

# --- STEP 3: CHECK FLAG ---
echo ""
echo "======================================"
echo "     CEK STATUS FLAG"
echo "======================================"
/usr/local/bin/03-checker.sh

echo ""
echo "[✓] Proses Selesai!"
echo ""
