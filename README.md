# jekyll-theme-coderic

Welcome to your new Jekyll theme! In this directory, you'll find the files you need to be able to package up your theme into a gem. Put your layouts in `_layouts`, your includes in `_includes`, your sass files in `_sass` and any other assets in `assets`.

To experiment with this code, add some sample content and run `bundle exec jekyll serve` – this directory is setup just like a Jekyll site!

TODO: Delete this and the text above, and describe your gem

## Installation

Con **`remote_theme: Coderic/jekyll-theme-coderic`**, Jekyll fusiona el `_config.yml` del tema. **No hace falta** `jekyll-sitemap`: el archivo **`assets/sitemap.xml`** del tema (Liquid, `permalink: /sitemap.xml`) lista cada URL **por idioma** (`site.languages`), compatible con **jekyll-polyglot**. En Jekyll 4 solo se cargan como páginas del tema los archivos bajo **`assets/`** (ThemeAssetsReader). **`robots.txt`** (misma plantilla Liquid) va en la **raíz de cada portal**, no en la gema del tema.

Instalación publicando el tema como gema Ruby: añadí `gem "jekyll-theme-coderic"` al `Gemfile` y en `_config.yml` usá `theme: jekyll-theme-coderic`. Luego ejecutá `bundle` (o `gem install jekyll-theme-coderic`).

## Usage

### Navegación de sección (`subnav`)

**No copies** `_includes/subnav.html` en tu sitio salvo necesidad excepcional: Jekyll usará el include del tema (`remote_theme` / `theme`). Define el menú solo en YAML.

El include `_includes/subnav.html` resuelve los datos en este orden:

1. `site.data[<active_lang>].subnav` → archivo `_data/<lang>/subnav.yml` (p. ej. `_data/es/subnav.yml`).
2. Si está vacío o ausente: `site.data[<default_lang>].subnav` → `_data/<default_lang>/subnav.yml`.
3. Si sigue vacío: **por defecto no** se usa ningún menú empaquetado ni `_data/subnav.yml` raíz (no se pinta subnav hasta tener YAML por idioma).
4. Solo si en `_config.yml` está **`use_theme_subnav_fallback: true`**: se asigna `site.data.subnav` (merge del sitio + datos del tema; útil en demos o sitios que solo definen `_data/subnav.yml` raíz).

Configuración útil en `_config.yml`:

- **`use_theme_subnav_fallback: true`**: tras los pasos 1–2, si aún no hay ítems, usar `site.data.subnav` (incluye demo del tema si no lo anulas con tus propios datos).
- **Omisión o `false`** (recomendado en producción con `_data/<lang>/subnav.yml`): si faltan datos por idioma, el subnav **no** muestra el menú del tema por defecto.

La clave antigua `hide_theme_subnav_fallback` **ya no tiene efecto**; sustituir por `use_theme_subnav_fallback` con la semántica anterior invertida (opt-in para usar el fallback del tema).

Los enlaces internos del menú pasan por `_includes/coderic_i18n_href.html` para convivir con **jekyll-polyglot**.

El conmutador de idioma del subnav usa los tags Liquid **`static_href` / `endstatic_href`** de Polyglot en los enlaces del menú. Los sitios sin Polyglot deben usar otro include o no incluir este bloque tal cual.

### Cabecera (`head`) y SEO

- **`_includes/seo_resolve.html`**: resuelve `<title>` y meta description para `page.net_page`, `page.i18n_source`, `page.i18n`, datos por `page.pages_data_key` y secciones `organization` / `impact` / `governance`, y fallbacks (`page.title`, `site.portal_name`, etc.).
- **`_includes/head.html`**: aplica esa resolución, añade **`rel="canonical"`**, alternates **`hreflang`** (más **`x-default`**), meta **Open Graph** (`og:title`, `og:description`, `og:url`, `og:type`, `og:locale`) y **Twitter Card** (`summary`). Con **`site.url`** vacío (demo local), se omiten canonical/OG para no emitir URLs rotas.
- Compatible con **jekyll-polyglot** (`site.active_lang`). Opcional: **`site.noindex`** añade meta robots noindex y `robots.txt` con `Disallow: /`.

### Sitemap y `robots.txt`

- **`assets/sitemap.xml`** (`permalink: /sitemap.xml`): recorre colecciones, `site.html_pages` y archivos estáticos (`.htm`/`.html`/`.xhtml`/`.pdf`) como el plugin oficial; para **cada** recurso HTML emite una entrada **por idioma** en `site.languages` (idioma por defecto con `absolute_url`; resto `/{lang}{path}`), alineado con las `hreflang` del `head`. Con Polyglot, `page.url` en la pasada `default_lang` no lleva prefijo; sin duplicar por idioma el sitemap omitía `/es/...`.
- El archivo está en **`exclude_from_localization`**: un solo `/sitemap.xml` en la raíz del sitio generado, como recomienda Polyglot.
- En producción, fijá **`url`** (y **`baseurl`**) en `_config.yml`.
- **`robots.txt`**: cada portal Coderic lo mantiene en la **raíz del repo del sitio** (misma plantilla Liquid que antes estaba en el tema): `noindex` → `Disallow: /`; si no, `Allow: /` y línea **`Sitemap:`** con `site.url` + `site.baseurl`. Mantener **`robots.txt`** en **`exclude_from_localization`** del sitio (junto con `sitemap.xml`) para Polyglot.
- Por defecto **`sitemap: false`** en el front matter de **`callback.html`**, **`profile.html`** y **`hello-world.html`** del tema; en otras páginas usá `sitemap: false` cuando no deban indexarse.
- **Google Search Console (“No se ha podido obtener”)**: revisá en **Cloudflare** que **Bot Fight Mode** / reglas WAF no bloqueen **Googlebot** en `GET /sitemap.xml`; en **Pages**, el archivo **`_headers`** en el repo (incluido vía `include` en `_config.yml`) fija `Content-Type` correcto. Un sitemap con **`<loc>` vacío** (XML inválido) también puede hacer fallar la lectura: la plantilla del tema omite esas entradas.

Referencias: [Google Search Central](https://developers.google.com/search/docs?hl=es-419).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jekyll-theme-coderic. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org/) code of conduct.

## Development

To set up your environment to develop this theme, run `bundle install`.

Your theme is setup just like a normal Jekyll site! To test your theme, run `bundle exec jekyll serve` and open your browser at `http://localhost:4000`. This starts a Jekyll server using your theme. Add pages, documents, data, etc. like normal to test your theme's contents. As you make modifications to your theme and to your content, your site will regenerate and you should see the changes in the browser after a refresh, just like normal.

When your theme is released, the files tracked in `jekyll-theme-coderic.gemspec` are bundled (layouts, includes such as `seo_resolve.html`, `_config.yml`, `assets/sitemap.xml`, páginas raíz OAuth, etc.). Cada portal del ecosistema incluye su propio `robots.txt` en la raíz del sitio. Edit the regexp in the gemspec if you add new top-level assets to the gem.

## OAuth 2.0 (ensayo / staging)

### AuthTester (Scott Brady) — PKCE con este tema

Para probar **Authorization Code + PKCE** contra un servidor OIDC de referencia (mismo flujo que usa el tema con `oauth_demo_sign_in: false` y `/callback/`):

- Herramienta: **[AuthTester](https://www.scottbrady.io/tools/auth-tester)** ([documentación del servicio](https://www.scottbrady.io/tools/auth-tester)).
- Descubrimiento OpenID: [`/.well-known/openid-configuration`](https://www.scottbrady.io/tools/auth-tester/.well-known/openid-configuration) — ahí salen `authorization_endpoint` y `token_endpoint`.
- En `_config.yml` del tema (valores por defecto del demo) se usan `oidc_client_id: "test"` y las URLs explícitas de authorize/token del tester, según lo descrito en la página del tool (“no client registration required” para empezar con `client_id=test`).
- Abrí el sitio con el **mismo origen** que `url` en `_config.yml` (p. ej. si `url` es `http://localhost:4000`, entrá con `http://localhost:4000`, no mezclar con `127.0.0.1`, porque el `redirect_uri` y `sessionStorage` del PKCE deben coincidir).

Si el tester te ofrece una pantalla **configure** con `requestId` en la URL (p. ej. `…/oauth/authorize/configure?requestId=…`), ese ID es **por sesión**: generalo desde la UI del AuthTester; no lo versiones en el repo.

Si el intercambio de `code` en el navegador falla por **CORS** en el `token_endpoint`, el AS no permite llamadas cross-origin desde el browser: en ese caso haría falta un backend (BFF) que canjee el código; el AuthTester suele estar pensado para pruebas de cliente.

### OAuth.com playground (opcional)

El **[OAuth 2.0 Playground](https://www.oauth.com/playground/index.html)** sirve para flujos guiados con servidor simulado; un flujo **Implicit** allí **no** usa el `redirect_uri` `/callback/` de este tema (ver sección Implicit más abajo).

#### Credenciales de ejemplo del playground (solo testing)

| Campo | Valor |
| --- | --- |
| `client_id` | `9Jyz5ULUVj0DhodVIypTLAnb` |
| `client_secret` | `8ltclob04WAcZ6jrnHQxQgzbxGIWRKBV29ypp-vgB9IQx_dm` |
| Usuario (login) | `cheerful-peafowl@example.com` |
| Contraseña | `Successful-Dove-72` |

Registro: [Client Registration](https://www.oauth.com/playground/client-registration.html).

#### Ejemplo Implicit (playground oauth.com)

No es el flujo PKCE del tema; solo referencia del playground con [`authorization-server.com`](https://authorization-server.com/):

```text
https://authorization-server.com/authorize?
  response_type=token
  &client_id=9Jyz5ULUVj0DhodVIypTLAnb
  &redirect_uri=https://www.oauth.com/playground/implicit.html
  &scope=photo
  &state=<valor-que-asigna-el-playground>
```

Con PKCE en este tema, el `redirect_uri` debe ser **`{origen}/callback/`** de tu sitio Jekyll.

## License

The theme is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
