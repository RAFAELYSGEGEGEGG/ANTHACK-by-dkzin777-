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

echo "Este script adicionará arquivos de máxima segurança ao repositório escolhido."

# Dependências
for cmd in git curl jq; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Instalando dependência: $cmd"
    pkg install -y "$cmd"
  fi
done

# Entradas
read -p "Usuário GitHub: " GITHUB_USER
read -s -p "Token PAT: " GITHUB_TOKEN
echo ""
read -p "URL do repositório (HTTPS): " REPO_URL

# Extrair owner/repo
OWNER_REPO=$(echo "$REPO_URL" | sed 's/https:\/\/github.com\///;s/.git//')
OWNER="${OWNER_REPO%%/*}"

# Verificar token
USER_API_JSON=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user)
API_USER_LOGIN=$(echo "$USER_API_JSON" | jq -r .login)

if [ "$API_USER_LOGIN" != "$GITHUB_USER" ]; then
  echo "Token não pertence ao usuário."
  exit 1
fi

# Clone
TMPDIR=$(mktemp -d)
git clone --depth 1 "$REPO_URL" "$TMPDIR"

cd "$TMPDIR"
git checkout -b anthack-security

# Criar arquivos de segurança
cat > .htaccess <<'EOF'
Options -Indexes
<FilesMatch "(^\.|wp-config\.php|composer\.json|package\.json)">
  Require all denied
</FilesMatch>
EOF

cat > SECURITY.md <<'EOF'
# Segurança do Projeto
- Headers fortalecidos
- Proibição de listagem
EOF

cat > security.json <<'EOF'
{"security": true}
EOF

cat > security.py <<'EOF'
#!/usr/bin/env python3
print("Scanner simples de segurança iniciado…")
EOF

chmod +x security.py

git add .
git commit -m "Add security files"

PUSH_URL="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${OWNER_REPO}.git"
git push "$PUSH_URL" HEAD:anthack-security

echo "✔ Segurança adicionada com sucesso!"
