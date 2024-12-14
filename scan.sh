#!/bin/bash

# IP range untuk segmen 4
network="192.168.4"

# Fungsi untuk menangani Ctrl+C (SIGINT) dan menghentikan pemindaian tanpa menutup halaman
trap 'echo -e "\nProses pemindaian dihentikan."; break' SIGINT

# Loop melalui IP 1-254
for i in {1..254}
do
    ip="$network.$i"
    
    # Ping IP sebanyak 4 kali untuk mengecek apakah server aktif
    ping -c 4 -w 5 $ip &> /dev/null

    if [ $? -eq 0 ]; then
        echo "Server ON: $ip"
        
        # Membuka IP di browser di latar belakang agar tetap berjalan meskipun pemindaian dihentikan
        xdg-open http://$ip &>/dev/null & disown
        # Atau, jika xdg-open tidak berfungsi, gunakan Firefox
        # firefox http://$ip &>/dev/null & disown
    else
        echo "Server OFF: $ip"
    fi
done
