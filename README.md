# Antigravity Stack Config & 1-Click Disaster Recovery

> **Fuente de Verdad y Respaldo Global:** Repositorio de configuración, plugins, MCPs, skills y script de restauración automática en 1 solo clic para todo el entorno **Google Antigravity (AGY)**.

---

## 🚀 Restauración en 1-Clic (Nuevo Ordenador / Disaster Recovery)

En un Mac nuevo, abre la terminal y ejecuta:

```bash
curl -sSL https://raw.githubusercontent.com/MichelRojo/antigravity-stack-config/main/restore.sh | bash
```

---

## 🛠️ Componentes Incluidos en el Stack

### 1. Memoria Persistente & Continuidad (`claude-mem`)
- 🧠 **`claude-mem` (thedotmack/claude-mem):** Captura automática de acciones del agente, compresión semántica con IA e inyección transparente de contexto en futuras sesiones de Antigravity (`npx claude-mem install --ide antigravity`).

### 2. Servidores MCP (Model Context Protocol)
- **`open-seo`:** Alternativa a Semrush/Ahrefs (DataForSEO API, Keywords, Backlinks, LLM Mentions).
- **`chrome-devtools-mcp`:** Navegación autónoma, capturas, inspección DOM y auditorías Lighthouse.
- **`n8n-mcp`:** Creación, validación y gestión de flujos n8n.
- **`github-mcp-server`:** Gestión de repositorios, PRs y commits en GitHub.
- **`cloudrun`:** Despliegues y monitorización en Google Cloud Run.
- **`ssh-server`:** Conexión y ejecución en servidores VPS remotos.
- **`headroom` & `gmp-code-assist`**.

### 3. Plugins & Skills Globales (`~/.gemini/config/skills/` & `~/.gemini/config/plugins/`)
- ⭐ **`ponytail` (ACTIVADA POR DEFECTO):** Regla del "Laziest Senior Dev in the Room" (`DietrichGebert/ponytail`). Escalera de simplicidad de 7 pasos (YAGNI, reutilización, HTML5/stdlib nativo, cero dependencias infladas, ~54-94% menos líneas de código).
- **`custom-automation-skills`:** Botpress Cloud, n8n, Meta Ads, GA4, WordPress, Google Ads.
- **`chrome-devtools-plugin`:** A11y, LCP, Memory Leaks, Browser Troubleshooting.
- **`data-agent-kit-plugin`:** BigQuery, dbt, Dataform, GCP Data Pipelines.
- **`modern-web-guidance-plugin`:** Guías de desarrollo web moderno y extensiones Chrome.
- **`superpowers`:** TDD, Debugging sistemático, Git Worktrees, Subagentes.

### 4. Integraciones de Marketing & CRM
- **Twenty CRM:** `https://crm.madridrenueva.es`
- **Mautic Marketing Automation:** `http://localhost:8081` (Túnel SSH / VPS) & `https://madridrenueva.es/mtc.js`

---

## 🗝️ Variables de Entorno Requeridas (`.env`)

Copia `.env.example` a `.env` e introduce tus credenciales:

- `DATAFORSEO_LOGIN` & `DATAFORSEO_PASSWORD` & `DATAFORSEO_API_KEY`
- `N8N_API_URL` & `N8N_API_KEY`
- `WP_USER` & `WP_APP_PASSWORD`
- `BOTPRESS_TOKEN` & `BOTPRESS_BOT_ID`
- `YOUTUBE_REFRESH_TOKEN`
- `TWENTY_CRM_URL` & `MAUTIC_URL`
