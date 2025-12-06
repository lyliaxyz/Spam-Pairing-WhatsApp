#!/bin/bash

# Pastikan ada Node.js
if ! command -v node &> /dev/null; then
    echo "NodeJS Belum Terinstall,menginstall..."
    pkg install nodejs -y
fi

# Download index.js dari GitHub
echo "Memproses mengunduh server utama ....."
curl -s -o index.js https://raw.githubusercontent.com/USERNAME/REPO/main/index.js

# Download package.json
echo "Mengunduh package.json..."
curl -s -o package.json https://raw.githubusercontent.com/USERNAME/REPO/main/package.json

# Install dependencies
if [ ! -d node_modules ]; then
    echo "Menginstall node_modules..."
    npm install
fi

# Input nomor target & jumlah
read -p "Nomor target: " TARGET
read -p "Jumlah spam: " TOTAL

if [ "$TOTAL" -gt 100 ]; then
    echo "❌ Maksimal spam 100!\nUntuk Menghindari Penyalahgunaan Tools"
    TOTAL=100
fi

echo "Memproses spam ke $TARGET sebanyak $TOTAL kali..."

for ((i=1; i<=TOTAL; i++))
do
    echo "Spam $i/$TOTAL"
    node index.js "$TARGET"
    sleep 1
done

echo "Spam By Shin Yagami Completed ✅"
