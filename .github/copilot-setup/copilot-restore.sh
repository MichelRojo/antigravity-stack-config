#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "Replicando MCPs, skills y plugins para Copilot/Antigravity"

# 1) Copy .env example if missing
if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
  echo "Copiado .env.example -> .env. Edita .env con tus credenciales antes de continuar."
fi

# 2) Install claude-mem (if not present)
if ! command -v claude-mem >/dev/null 2>&1; then
  echo "Instalando claude-mem (global)"
  npm install -g claude-mem --legacy-peer-deps || {
    echo "Fallo en npm install: intenta 'npm install -g claude-mem --legacy-peer-deps' manualmente"
  }
else
  echo "claude-mem ya está instalado"
fi

# 3) Register claude-mem plugin for local IDE target (safe, idempotent)
if command -v claude-mem >/dev/null 2>&1; then
  echo "Registrando claude-mem para el IDE objetivo (copilot/antigravity)"
  # Use 'antigravity' by default; user can change to 'copilot' if desired
  claude-mem install --ide antigravity || echo "Advertencia: fallo al registrar los hooks. Revisa permisos."
  echo "Para iniciar el worker: claude-mem start"
fi

# 4) Install local skills from repo (ponytail)
if [ -f "skills/ponytail/SKILL.md" ]; then
  echo "La skill 'ponytail' está incluida en el repo en skills/ponytail/SKILL.md — copiar a ~/.gemini/config/skills/"
  mkdir -p ~/.gemini/config/skills
  cp -n skills/ponytail/SKILL.md ~/.gemini/config/skills/ponytail.SKILL.md || true
  echo "'ponytail' copiada a ~/.gemini/config/skills/ponytail.SKILL.md"
fi

# 5) Write recommended MCP config snippets to ~/.gemini/config/mcp_config.json (dry-merge)
MCP_DST="$HOME/.gemini/config"
mkdir -p "$MCP_DST"
cat > "$MCP_DST/mcp_config.example.json" <<JSON
{
  "mcpServers": {
    "apify": { "serverUrl": "https://mcp.apify.com" }
  }
}
JSON

echo "Se escribió ~/.gemini/config/mcp_config.example.json. Mueve/mezcla con tu mcp_config.json y añade tokens en .env"

echo "Restauración local completada (pasos manuales: editar .env, revisar mcp_config.json y reiniciar Copilot/Antigravity)."
