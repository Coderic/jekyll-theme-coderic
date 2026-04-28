# jekyll-theme-coderic

Welcome to your new Jekyll theme! In this directory, you'll find the files you need to be able to package up your theme into a gem. Put your layouts in `_layouts`, your includes in `_includes`, your sass files in `_sass` and any other assets in `assets`.

To experiment with this code, add some sample content and run `bundle exec jekyll serve` – this directory is setup just like a Jekyll site!

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your Jekyll site's `Gemfile`:

```ruby
gem "jekyll-theme-coderic"
```

And add this line to your Jekyll site's `_config.yml`:

```yaml
theme: jekyll-theme-coderic
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jekyll-theme-coderic

## Usage

TODO: Write usage instructions here. Describe your available layouts, includes, sass and/or assets.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jekyll-theme-coderic. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org/) code of conduct.

## Development

To set up your environment to develop this theme, run `bundle install`.

Your theme is setup just like a normal Jekyll site! To test your theme, run `bundle exec jekyll serve` and open your browser at `http://localhost:4000`. This starts a Jekyll server using your theme. Add pages, documents, data, etc. like normal to test your theme's contents. As you make modifications to your theme and to your content, your site will regenerate and you should see the changes in the browser after a refresh, just like normal.

When your theme is released, only the files in `_layouts`, `_includes`, `_sass` and `assets` tracked with Git will be bundled.
To add a custom directory to your theme-gem, please edit the regexp in `jekyll-theme-coderic.gemspec` accordingly.

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
