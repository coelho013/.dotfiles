#!/usr/bin/env bash
# Instala e configura o ai-memory (https://github.com/akitaonrails/ai-memory).
#
# Uso: ./ai-memory/install.sh [--update]
#   --update  baixa a última release mesmo se já estiver instalado
#
# Idempotente: `ai-memory setup` não altera nada se já estiver configurado.
set -euo pipefail

INSTALLER_URL="https://github.com/akitaonrails/ai-memory/releases/latest/download/install.sh"
export PATH="$HOME/.local/bin:$PATH"

update=false
[[ ${1:-} == "--update" ]] && update=true

if $update || ! command -v ai-memory >/dev/null 2>&1; then
  echo "==> Baixando ai-memory"
  curl -fsSL "$INSTALLER_URL" | sh
else
  echo "==> ai-memory já instalado ($(ai-memory --version))"
fi

# init + serviço systemd --user + hooks/MCP/skills dos agentes detectados
echo "==> Configurando ai-memory"
ai-memory setup --yes
