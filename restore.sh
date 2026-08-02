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

# 4. Instalar Claude-Mem (Memoria Persistente para Antigravity)
# Documentación: plugins/claude-mem/README.md
echo ""
echo "🧠 Instalando Claude-Mem (Memoria Persistente)..."
if command -v claude-mem &> /dev/null; then
    echo "✅ Claude-Mem ya instalado: $(claude-mem --version 2>&1)"
else
    # El flag --legacy-peer-deps resuelve un conflicto benigno de tree-sitter-lua
    npm install -g claude-mem --legacy-peer-deps
    echo "✅ Claude-Mem instalado: $(claude-mem --version 2>&1)"
fi

echo "🔧 Configurando hooks de Claude-Mem para Antigravity..."
claude-mem install --ide antigravity

echo "🔄 Arrancando worker de Claude-Mem en background..."
claude-mem start &
sleep 2

if claude-mem status 2>&1 | grep -q "Worker is running"; then
    echo "✅ Worker de Claude-Mem activo (PID detectado, puerto 37701)"
else
    echo "⚠️  Worker de Claude-Mem no detectado activo. Ejecuta manualmente: claude-mem start"
fi

echo ""
echo "🎉 ¡RESTAURACIÓN DE INFRAESTRUCTURA COMPLETADA CON ÉXITO!"
echo ""
echo "📌 Próximos pasos:"
echo "   1. Copia tus credenciales en el archivo .env para reactivar todos los servicios."
echo "   2. Reinicia Antigravity CLI (agy) para cargar los hooks de Claude-Mem."
echo "   3. La memoria se captura automáticamente desde la primera sesión."
