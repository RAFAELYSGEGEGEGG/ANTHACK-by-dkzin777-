#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

clear
echo -e "\e[31m
 █████╗ ███╗   ██╗████████╗██╗  ██╗ █████╗  ██████╗██╗  ██╗
██╔══██╗████╗  ██║╚══██╔══╝██║  ██║██╔══██╗██╔════╝██║ ██╔╝
███████║██╔██╗ ██║   ██║   ███████║███████║██║     █████╔╝
██╔══██║██║╚██╗██║   ██║   ██╔══██║██╔══██║██║     ██╔═██╗
██║  ██║██║ ╚████║   ██║   ██║  ██║██║  ██║╚██████╗██║  ██╗
╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
        ━━━ ANTHACK SECURITY MAX ━━━
\e[0m"

echo "Instalando dependências..."
pkg update -y
pkg install -y curl git jq python

echo "Baixando script principal..."

GITHUB_USER="SEU_USUARIO"
GITHUB_REPO="SEU_REPOSITORIO"
SCRIPT_NAME="anthack.sh"

RAW_URL="https://raw.githubusercontent.com/$GITHUB_USER/$GITHUB_REPO/main/$SCRIPT_NAME"

curl -s -L "$RAW_URL" -o /data/data/com.termux/files/usr/tmp/anthack_exec.sh
chmod +x /data/data/com.termux/files/usr/tmp/anthack_exec.sh

bash /data/data/com.termux/files/usr/tmp/anthack_exec.sh
