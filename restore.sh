#!/usr/bin/env bash

# ==============================================================================
# Script de Restauración Automática en 1 Clic para Google Antigravity (AGY)
# ==============================================================================

set -e

echo "🚀 Iniciando restauración automática del Stack de Antigravity..."

# 1. Crear directorios base si no existen
mkdir -p "$HOME/.gemini/antigravity/mcp"
mkdir -p "$HOME/.gemini/config/plugins"
mkdir -p "$HOME/.gemini/config/skills"

# 2. Verificar Homebrew y Node.js / pnpm
if ! command -v node &> /dev/null; then
    echo "📦 Instalando Node.js..."
    brew install node
fi

if ! command -v pnpm &> /dev/null; then
    echo "📦 Instalando pnpm..."
    npm install -g pnpm
fi

# 3. Clonar / Restaurar MCP Server de Open-SEO
if [ ! -d "$HOME/.gemini/antigravity/mcp/open-seo" ]; then
    echo "📥 Clonando e instalando Open-SEO MCP..."
    git clone https://github.com/every-app/open-seo.git "$HOME/.gemini/antigravity/mcp/open-seo"
    cd "$HOME/.gemini/antigravity/mcp/open-seo"
    pnpm install
    pnpm run build
else
    echo "✅ Open-SEO MCP ya presente en el sistema."
fi

echo ""
echo "🎉 ¡RESTAURACIÓN DE INFRAESTRUCTURA COMPLETADA CON ÉXITO!"
echo "📌 Copia tus credenciales en el archivo .env para reactivar todos los servicios."
