#!/bin/bash

# IP range untuk segmen 4
network="192.168.4"

# Fungsi untuk menangani Ctrl+C (SIGINT) dan menghentikan pemindaian
trap 'echo -e "\nProses pemindaian dihentikan."; exit 0' SIGINT

# Loop melalui IP 1-254
for i in {1..254}
do
    ip="$network.$i"
    
    # Ping IP sebanyak 4 kali untuk mengecek apakah server aktif
    ping -c 4 -w 5 $ip &> /dev/null

    if [ $? -eq 0 ]; then
        echo "Server sedang aktif: $ip"
        
        # Membuka IP di browser di latar belakang agar tetap berjalan meskipun pemindaian dihentikan
        xdg-open http://$ip &>/dev/null & || firefox http://$ip &>/dev/null &
    else
        echo "Server tidak aktif: $ip"
    fi
done
