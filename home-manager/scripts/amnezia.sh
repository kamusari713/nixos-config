#!/usr/bin/env bash

BIN_PATH=$(find /nix/store -type f -path "*/bin/amnezia-vpn" | head -n 1)

if [ -n "$BIN_PATH" ]; then
    echo "Найден бинарник: $BIN_PATH"
    chmod +x "$BIN_PATH"
    chown kamusari:kamusari "$BIN_PATH"
    echo "Выданы права на исполнение ✅"
else
    echo "Ошибка: бинарник Amnezia VPN не найден в Nix Store ❌"
    exit 1
fi

systemctl restart amnezia-vpn.service
echo "Сервис перезапущен 🔄"
