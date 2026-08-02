# Claude-Mem — Memoria Persistente para Antigravity

> **Plugin de Memoria Persistente:** Captura automática de contexto de sesiones, compresión semántica con IA e inyección transparente en futuras sesiones de Antigravity (AGY).

---

## 📦 Versión Instalada

- **Versión:** `13.12.4`
- **Origen:** [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem)
- **IDE Target:** `antigravity`
- **Fecha de Instalación:** 2026-08-02

---

## 🔧 Instalación (incluida en `restore.sh`)

```bash
# 1. Instalar globalmente
npm install -g claude-mem --legacy-peer-deps

# 2. Configurar hooks + MCP para Antigravity
claude-mem install --ide antigravity

# 3. Arrancar el worker en background
claude-mem start
```

> **Nota:** El flag `--legacy-peer-deps` es necesario para resolver un conflicto benigno de peer-dependency con `tree-sitter-lua@0.4.1`. No afecta al funcionamiento del plugin.

---

## ⚙️ Archivos Modificados por la Instalación

| Archivo | Cambio |
|---|---|
| `~/.gemini/settings.json` | 7 hooks registrados (SessionStart, BeforeAgent, AfterAgent, BeforeTool, AfterTool, Notification, PreCompress) |
| `~/.gemini/GEMINI.md` | Placeholder `<claude-mem-context>` inyectado para contexto de sesiones anteriores |
| `~/.gemini/antigravity/mcp_config.json` | MCP de claude-mem registrado |
| `~/.gemini/config/mcp_config.json` | MCP de claude-mem registrado (global) |
| `~/.agents/rules/claude-mem-context.md` | Archivo de contexto persistente entre sesiones |

---

## 🔁 Los 7 Hooks Activos

| Hook | Evento | Acción |
|---|---|---|
| 1 | `SessionStart` | Inyecta contexto de sesiones anteriores en el prompt |
| 2 | `BeforeAgent` | Inicializa el registro de la sesión actual |
| 3 | `AfterAgent` | Captura observaciones post-respuesta |
| 4 | `BeforeTool` | Registra el uso de herramientas |
| 5 | `AfterTool` | Captura resultados de herramientas |
| 6 | `Notification` | Registra notificaciones del sistema |
| 7 | `PreCompress` | Resume el contexto antes de la compresión de ventana |

---

## 🧠 Cómo Funciona

```
Sesión 1  →  Worker captura: herramientas, archivos, decisiones
             Worker comprime y almacena en ~/.claude-mem

Sesión 2  →  Hook SessionStart inyecta el resumen en GEMINI.md
             Antigravity lee el contexto y continúa donde lo dejó
```

1. **Primera sesión:** El worker observa y captura todas las acciones.
2. **Entre sesiones:** Compresión semántica del contexto con IA.
3. **Segunda sesión en adelante:** Contexto inyectado automáticamente.

---

## 🛠️ Comandos de Gestión

```bash
claude-mem status    # Ver estado del worker (PID, puerto, uptime)
claude-mem start     # Arrancar el worker
claude-mem stop      # Detener el worker
claude-mem restart   # Reiniciar el worker
claude-mem logs      # Ver logs en tiempo real (puerto 37701)
```

---

## ⚠️ Nota sobre el Conflicto de tree-sitter

Durante la instalación aparece el siguiente error:

```
npm error: Could not resolve dependency:
npm error peerOptional tree-sitter@"^0.22.4" from @tree-sitter-grammars/tree-sitter-lua@0.4.1
```

**Es benigno.** Claude-mem resuelve automáticamente con `--legacy-peer-deps`. El worker arranca y funciona correctamente con Bun runtime (`bun 1.3.14`) y `uv 0.11.28`.
