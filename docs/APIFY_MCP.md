# 🚀 Guía de Integración: Apify MCP Server en Antigravity

Esta documentación describe la instalación, configuración y uso del servidor **Apify Model Context Protocol (MCP)** como capacidad central global en el entorno de **Antigravity**.

---

## 📌 Visión General

El servidor MCP de Apify (`https://mcp.apify.com`) permite que los agentes de IA de Antigravity descubran y ejecuten más de 3,000 *Actors* (scrapers, crawlers y automatizaciones) de [Apify Store](https://apify.com/store), así como acceder a los datasets y almacenamientos de Apify.

### ✨ Principales Ventajas
- **Extracción a gran escala sin bloqueos**: Rotación de proxies, resolución de CAPTCHAs y renderizado headless en la nube de Apify.
- **Inferencia de Esquemas de Salida (*Output Schema Inference*)**: Antigravity comprende la estructura de los datos devueltos (campos, tipos) antes de realizar llamadas a los *Actors*.
- **Optimizado para RAG y IA**: Crawling de sitios completos convertidos a texto Markdown limpio para entrenamiento o bases vectoriales.
- **Configuración Centralizada**: Disponible automáticamente en todos tus proyectos en Antigravity.

---

## ⚙️ Configuración del Servidor MCP

La configuración se almacena en el archivo global de Antigravity:

📂 `~/.gemini/antigravity/mcp_config.json`

```json
{
  "mcpServers": {
    "apify": {
      "serverUrl": "https://mcp.apify.com",
      "headers": {
        "Authorization": "Bearer APIFY_TOKEN_HERE"
      }
    }
  }
}
```

> ⚠️ **Nota de Seguridad**: Nunca subas tu token de API privado (`apify_api_...`) a repositorios públicos de GitHub. Si compartes tu repositorio de configuración, utiliza variables de entorno o placeholders.

---

## 🛠️ Capacidades Disponibles

| Categoría | Actors destacados / Herramientas | Caso de Uso en Antigravity |
| :--- | :--- | :--- |
| **RAG & IA Data Prep** | `apify/website-content-crawler` | Convertir webs completas a Markdown limpio para RAG |
| **Leads & Negocios** | `apify/google-maps-scraper` | Extraer contactos, teléfonos, reviews y ubicaciones |
| **Social Media Mining** | Instagram, TikTok, LinkedIn, YouTube, Twitter/X | Scrapear posts, perfiles, tendencias y comentarios |
| **Ecommerce & Retail** | Amazon, Mercado Libre, Shopify, eBay | Comparación de precios, catálogos y stock |
| **Real Estate & Travel** | Airbnb, Booking, Zillow, Idealista | Extracción de listings, precios y disponibilidades |
| **Storage Access** | Datasets, Key-Value Stores, Request Queues | Consulta directa de ejecuciones y datasets en la nube |

---

## 💡 Ejemplos de Prompts para Usar con Antigravity

### 1. Preparación de datos para RAG / Documentación
> *"Usa el Actor Website Content Crawler de Apify para extraer todo el contenido de `https://docs.ejemplo.com` en formato Markdown y guárdalo en la carpeta `data/`."*

### 2. Generación de Leads de Negocios Locales
> *"Ejecuta el Google Maps Scraper de Apify para buscar restaurantes en Madrid. Extrae nombre, teléfono, puntuación y dirección de los primeros 30 resultados."*

### 3. Estudio de Mercado / Reseñas de Usuarios
> *"Scrapea las últimas 50 reseñas de este producto en Amazon usando Apify y analiza los principales puntos negativos mencionados por los clientes."*

---

## 💰 Modelo de Tarifas y Cuota Gratuita

- **Plan Gratuito Permanente**: $5 USD de crédito renovable cada mes en Apify.
- **Actors Gratuitos**: Los Actors oficiales de Apify no cobran tarifa de uso, únicamente consumen el cómputo/proxy de tus $5 mensuales.
- **Protección contra sobrecostes**: Si se agotan los $5 mensuales en el plan gratuito, las ejecuciones se pausan automáticamente sin realizar cargos a la tarjeta.
