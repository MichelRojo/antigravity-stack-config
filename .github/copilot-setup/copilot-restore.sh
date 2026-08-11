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

# Optional: apply a prepared config artifact (zip) that contains mcp_config.json and .env
if [ "${1-}" = "--apply-artifact" ] && [ -f "${2-}" ]; then
  ARTIFACT="$2"
  echo "Aplicando artifact de configuración: $ARTIFACT"
  TMP_DIR=$(mktemp -d)
  unzip -q "$ARTIFACT" -d "$TMP_DIR" || { echo "Fallo al descomprimir $ARTIFACT"; rm -rf "$TMP_DIR"; exit 1; }

  # Apply .env if present (copy to repo root .env, but do NOT commit)
  if [ -f "$TMP_DIR/.env" ]; then
    cp "$TMP_DIR/.env" ./ .env
    echo "Se copió .env desde el artifact a ./ .env (no comiteado). Edita si es necesario."
  fi

  # Copy generated mcp configs into ~/.gemini/config and ~/.gemini/antigravity
  mkdir -p "$HOME/.gemini/config" "$HOME/.gemini/antigravity"
  if [ -f "$TMP_DIR/mcp_config.json" ]; then
    cp "$TMP_DIR/mcp_config.json" "$HOME/.gemini/config/mcp_config.json"
    echo "Instalado ~/.gemini/config/mcp_config.json"
  fi
  if [ -f "$TMP_DIR/antigravity_mcp_config.json" ]; then
    cp "$TMP_DIR/antigravity_mcp_config.json" "$HOME/.gemini/antigravity/mcp_config.json"
    echo "Instalado ~/.gemini/antigravity/mcp_config.json"
  fi

  rm -rf "$TMP_DIR"
  echo "Aplicación del artifact completada. Revisa ~/.gemini y reinicia Copilot/Antigravity si es necesario."
fi

echo "Restauración local completada (pasos manuales: editar .env, revisar mcp_config.json y reiniciar Copilot/Antigravity)."
