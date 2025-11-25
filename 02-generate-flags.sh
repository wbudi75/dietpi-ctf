#!/bin/bash

# Pastikan nama kelompok sudah ada
if [ ! -f /etc/ctf_groupname ]; then
    echo "[!] Nama kelompok belum diset!"
    exit 1
fi

GROUP=$(cat /etc/ctf_groupname)

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

mkdir -p /home/ctf

for i in {1..10}; do
    INDEX=$(printf "%02d" $i)

    FLAG="smkctf{${GROUP}_fl4g_${INDEX}_"

    case $i in
        1) FLAG+="1s_34sy}" ;;
        2) FLAG+="t00_34sy}" ;;
        3) FLAG+="m0r3_fun}" ;;
        4) FLAG+="k33p_g01ng}" ;;
        5) FLAG+="h4lf_w4y}" ;;
        6) FLAG+="b4s364_lvl1}" ;;
        7) FLAG+="b4s364_lvl2}" ;;
        8) FLAG+="b4s364_lvl3}" ;;
        9) FLAG+="n3xt_st3p}" ;;
        10) FLAG+="1ts_0v3r}" ;;
    esac

    # Flag terenkripsi base64 untuk 6-10
    if [ $i -ge 6 ]; then
        OUT=$(echo -n "$FLAG" | base64)
    else
        OUT="$FLAG"
    fi

    DIR=${FLAG_DIRS[$((i-1))]}
    mkdir -p "$DIR"
    echo "$OUT" > "$DIR/flag.txt"

    echo "[✓] Flag $i dibuat di $DIR/flag.txt"
done

echo ""
echo "[✓] Semua flag berhasil dibuat."
