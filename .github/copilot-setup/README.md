Copilot setup: replicar capacidades de Antigravity

Contenido
- manifest.yml — lista de MCPs, skills y plugins a replicar
- copilot-restore.sh — script reproducible para registrar/installar lo soportado

Uso (recomendado):
1) Revisa manifest.yml y completa credenciales en .env (no subirlas)
2) Ejecuta: bash .github/copilot-setup/copilot-restore.sh
3) Revisa mensajes y reinicia las herramientas de Copilot/Antigravity según se indique

Advertencias:
- El script no sube credenciales ni tokens a GitHub.
- Evita sobrescribir configuraciones globales sin revisar.
