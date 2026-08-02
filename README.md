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

| Campo | Valor |
|---|---|
| **Plugin** | `claude-mem` ([thedotmack/claude-mem](https://github.com/thedotmack/claude-mem)) |
| **Versión** | `13.12.4` |
| **Estado** | ✅ Instalado globalmente |
| **Worker** | ✅ Activo en background (puerto `37701`) |
| **IDE Target** | `antigravity` |
| **Documentación** | [`plugins/claude-mem/README.md`](./plugins/claude-mem/README.md) |

- **🧠 Funcionalidad:** Captura automática de acciones del agente, compresión semántica e inyección transparente de contexto entre sesiones via `~/.gemini/GEMINI.md`.
- **7 Hooks activos:** `SessionStart`, `BeforeAgent`, `AfterAgent`, `BeforeTool`, `AfterTool`, `Notification`, `PreCompress`.
- **Runtime:** Bun `1.3.14` + `uv 0.11.28`.

---

### 2. Servidores MCP (Model Context Protocol)

| MCP Server | Función |
|---|---|
| `open-seo` | Alternativa a Semrush/Ahrefs (DataForSEO API, Keywords, Backlinks, LLM Mentions) |
| `chrome-devtools-mcp` | Navegación autónoma, capturas, inspección DOM y auditorías Lighthouse |
| `n8n-mcp` | Creación, validación y gestión de flujos n8n |
| `github-mcp-server` | Gestión de repositorios, PRs y commits en GitHub |
| `cloudrun` | Despliegues y monitorización en Google Cloud Run |
| `ssh-server` | Conexión y ejecución en servidores VPS remotos |
| `headroom` | Contexto optimizado para ventanas grandes |
| `gmp-code-assist` | Asistencia para código Google Maps Platform |
| `claude-mem MCP` | MCP de memoria persistente (configurado en `~/.gemini/config/mcp_config.json`) |

---

### 3. Plugins & Skills Globales

Ubicación: `~/.gemini/config/skills/` & `~/.gemini/config/plugins/`

| Plugin / Skill | Estado | Descripción |
|---|---|---|
| ⭐ **`ponytail`** | ACTIVA POR DEFECTO | "Laziest Senior Dev in the Room" — Escalera de simplicidad de 7 pasos. ~54-94% menos código |
| **`superpowers`** | ✅ Activo | TDD, Debugging sistemático, Git Worktrees, Subagentes, Planes de implementación |
| **`custom-automation-skills`** | ✅ Activo | Botpress Cloud, n8n, Meta Ads, GA4, WordPress, Google Ads |
| **`chrome-devtools-plugin`** | ✅ Activo | A11y, LCP, Memory Leaks, Browser Troubleshooting |
| **`data-agent-kit-plugin`** | ✅ Activo | BigQuery, dbt, Dataform, GCP Data Pipelines |
| **`modern-web-guidance-plugin`** | ✅ Activo | Guías de desarrollo web moderno y extensiones Chrome |

---

### 4. Integraciones de Marketing & CRM

| Servicio | URL / Endpoint |
|---|---|
| Twenty CRM | `https://crm.madridrenueva.es` |
| Mautic Marketing Automation | `http://localhost:8081` (Túnel SSH) & `https://madridrenueva.es/mtc.js` |

---

## 🔑 Variables de Entorno Requeridas (`.env`)

Copia `.env.example` a `.env` e introduce tus credenciales:

```bash
cp .env.example .env
# Edita .env con tus credenciales reales
```

Variables requeridas:
- `DATAFORSEO_LOGIN` & `DATAFORSEO_PASSWORD` & `DATAFORSEO_API_KEY`
- `N8N_API_URL` & `N8N_API_KEY`
- `WP_USER` & `WP_APP_PASSWORD`
- `BOTPRESS_TOKEN` & `BOTPRESS_BOT_ID`
- `YOUTUBE_REFRESH_TOKEN`
- `TWENTY_CRM_URL` & `MAUTIC_URL`

---

## 📁 Estructura del Repositorio

```
antigravity-stack-config/
├── README.md              # Este archivo — fuente de verdad
├── restore.sh             # Script de restauración en 1-clic
├── .env.example           # Plantilla de credenciales
└── plugins/
    └── claude-mem/
        └── README.md      # Documentación de Claude-Mem (hooks, worker, comandos)
```

---

## 📅 Historial de Cambios

| Fecha | Cambio |
|---|---|
| 2026-08-02 | Creación inicial del repositorio con Open-SEO MCP y stack base |
| 2026-08-02 | Instalación y documentación de `ponytail` skill (global, activa por defecto) |
| 2026-08-02 | Instalación y documentación de `claude-mem v13.12.4` con 7 hooks y worker activo |
