# plume

[![Package Version](https://img.shields.io/hexpm/v/plume)](https://hex.pm/packages/plume)
[![Downloads](https://img.shields.io/hexpm/dt/plume)](https://hex.pm/packages/plume)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/plume/)
[![Test](https://github.com/scott-ray-wilson/plume/actions/workflows/test.yml/badge.svg)](https://github.com/scott-ray-wilson/plume/actions/workflows/test.yml)
[![License](https://img.shields.io/hexpm/l/plume)](https://github.com/scott-ray-wilson/plume/blob/main/LICENSE)

Sensible defaults for HTTP security headers in Gleam web servers. Covers CSP, HSTS, X-Frame-Options, and more. Override or disable any header as needed.

Inspired by [helmet](https://helmetjs.github.io/) and built on
[gleam_http](https://hexdocs.pm/gleam_http/), so it works with
[wisp](https://hexdocs.pm/wisp/), [mist](https://hexdocs.pm/mist/), or any
other compatible server.

## Install

```sh
gleam add plume@1
```

## Quick start

As `use` middleware, e.g. with [wisp](https://hexdocs.pm/wisp/):

```gleam
import plume
import wisp.{type Request, type Response}

pub fn handle_request(_req: Request) -> Response {
  use <- plume.middleware(plume.default())
  wisp.ok()
}
```

Or directly on a response, e.g. with [mist](https://hexdocs.pm/mist/):

```gleam
import gleam/bytes_tree
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import mist.{type Connection, type ResponseData}
import plume

pub fn handle_request(_req: Request(Connection)) -> Response(ResponseData) {
  response.new(200)
  |> response.set_body(mist.Bytes(bytes_tree.from_string("Hello!")))
  |> plume.set_headers(plume.default())
}
```

## Configuration

Start from `plume.default()` and override individual fields with record
update syntax. 

To configure a header, pass header-specific options:

```gleam
import gleam/option.{Some}
import plume
import plume/frame_options

plume.Config(
  ..plume.default(),
  frame_options: Some(frame_options.Deny),
)
```

To disable a header, set its field to `None`:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), content_security_policy: None)
```

If you'd rather opt in header-by-header instead of starting from defaults,
use `plume.new()` as your base — it sets no headers.

Each header lives in its own submodule (e.g. `plume/content_security_policy`,
`plume/strict_transport_security`) with typed variants for every directive.
Further documentation can be found at <https://hexdocs.pm/plume>.

## Headers

`plume.default()` ships with sensible default values for most of the headers below.

<details>
<summary><code>Content-Security-Policy</code></summary>

Default (rendered on one line; wrapped here for readability):

```
Content-Security-Policy:
  default-src 'self';
  base-uri 'self';
  font-src 'self' https: data:;
  form-action 'self';
  frame-ancestors 'self';
  img-src 'self' data:;
  object-src 'none';
  script-src 'self';
  script-src-attr 'none';
  style-src 'self' https: 'unsafe-inline';
  upgrade-insecure-requests
```

Restricts which resources the browser may load for a page; mitigates XSS and
data injection. The default locks resources down to the document's own
origin, then adds the escape hatches real-world sites tend to need:

- `script-src 'self'` deliberately omits `'unsafe-inline'` — inline scripts
  are the primary XSS vector. Use a nonce or hash to allow specific ones.
- `script-src-attr 'none'` blocks inline event handlers like `onclick="…"`.
- `object-src 'none'` blocks `<object>` and `<embed>`, both historic XSS
  vectors.
- `base-uri 'self'` and `form-action 'self'` stop injected markup from
  rebasing relative URLs or hijacking form submissions.
- `frame-ancestors 'self'` is the modern CSP equivalent of `X-Frame-Options:
  SAMEORIGIN`. Modern browsers honor `frame-ancestors` and ignore
  `X-Frame-Options` when both are present; the latter is kept as a fallback
  for legacy clients.
- `font-src` and `img-src` allow `data:` URIs — inline fonts and images are
  common, and neither executes scripts in modern browsers. (SVGs loaded via
  `<img>`, in particular, don't run their `<script>` elements.) Tighten
  `font-src` if you serve untrusted user uploads as fonts.
- `font-src` and `style-src` allow any `https:` origin so CDN-hosted assets
  work without further configuration.
- `style-src 'unsafe-inline'` is included because hashing or noncing every
  inline style is impractical, and inline styles can't execute scripts
  (though CSS injection has its own narrower risks, like data exfiltration
  via attribute selectors).
- `upgrade-insecure-requests` rewrites `http://` subresources to `https://`,
  catching mixed-content bugs without breaking the page.

Customize via `plume/content_security_policy`:

```gleam
import gleam/option.{Some}
import plume
import plume/content_security_policy as csp

plume.Config(
  ..plume.new(),
  content_security_policy: Some(csp.Policy([
    csp.DefaultSrc([csp.Self]),
    csp.BaseUri([csp.Self]),
    csp.FontSrc([csp.Self, csp.Scheme("https"), csp.Scheme("data")]),
    csp.FormAction([csp.Self]),
    csp.FrameAncestors([csp.Self]),
    csp.ImgSrc([csp.Self, csp.Scheme("data")]),
    csp.ObjectSrc([csp.None]),
    csp.ScriptSrc([csp.Self]),
    csp.ScriptSrcAttr([csp.None]),
    csp.StyleSrc([csp.Self, csp.Scheme("https"), csp.UnsafeInline]),
    csp.UpgradeInsecureRequests,
  ])),
)
```

To remove the header:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), content_security_policy: None)
```

See the [MDN docs][csp].

</details>

<details>
<summary><code>Cross-Origin-Embedder-Policy</code></summary>

Not set by default.

Controls whether the document can load cross-origin resources that don't
explicitly grant permission via CORS or `Cross-Origin-Resource-Policy`.
Required alongside `Cross-Origin-Opener-Policy` to enable cross-origin
isolation, which gates powerful APIs like `SharedArrayBuffer` and
high-resolution `performance.now()`.

Left unset because `require-corp` only works if every cross-origin
resource the page loads also opts in, which is too app-specific for a safe
default.

To enable via `plume/cross_origin_embedder_policy`:

```gleam
import gleam/option.{Some}
import plume
import plume/cross_origin_embedder_policy as coep

plume.Config(
  ..plume.new(),
  cross_origin_embedder_policy: Some(coep.RequireCorp),
)
```

See the [MDN docs][coep].

</details>

<details>
<summary><code>Cross-Origin-Opener-Policy</code></summary>

Default:

```
Cross-Origin-Opener-Policy: same-origin
```

Isolates the browsing context from cross-origin openers and popups. Required
alongside `Cross-Origin-Embedder-Policy` to enable cross-origin isolation.

Customize via `plume/cross_origin_opener_policy`:

```gleam
import gleam/option.{Some}
import plume
import plume/cross_origin_opener_policy as coop

plume.Config(
  ..plume.new(),
  cross_origin_opener_policy: Some(coop.SameOrigin),
)
```

To remove the header:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), cross_origin_opener_policy: None)
```

See the [MDN docs][coop].

</details>

<details>
<summary><code>Cross-Origin-Resource-Policy</code></summary>

Default:

```
Cross-Origin-Resource-Policy: same-origin
```

Tells browsers to refuse cross-origin loads of this resource initiated via
no-cors requests (e.g. `<script>`, `<img>`).

Customize via `plume/cross_origin_resource_policy`:

```gleam
import gleam/option.{Some}
import plume
import plume/cross_origin_resource_policy as corp

plume.Config(
  ..plume.new(),
  cross_origin_resource_policy: Some(corp.SameOrigin),
)
```

To remove the header:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), cross_origin_resource_policy: None)
```

See the [MDN docs][corp].

</details>

<details>
<summary><code>Origin-Agent-Cluster</code></summary>

Default:

```
Origin-Agent-Cluster: ?1
```

Requests origin-keyed agent clustering, isolating the document from same-site
cross-origin documents. May also let the browser give the origin its own
process or thread.

Customize via `plume/origin_agent_cluster`:

```gleam
import gleam/option.{Some}
import plume
import plume/origin_agent_cluster as oac

plume.Config(
  ..plume.new(),
  origin_agent_cluster: Some(oac.Enabled),
)
```

To remove the header:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), origin_agent_cluster: None)
```

See the [MDN docs][oac].

</details>

<details>
<summary><code>Permissions-Policy</code></summary>

Not set by default.

Declares which browser features (camera, geolocation, etc.) the document and
embedded frames may use. Left unset because the right policy depends entirely
on the app's feature surface; configure it once you know yours.

To enable via `plume/permissions_policy`:

```gleam
import gleam/option.{Some}
import plume
import plume/permissions_policy as pp

plume.Config(
  ..plume.new(),
  permissions_policy: Some(pp.Policy([
    // Empty allowlist disables the feature everywhere.
    pp.Camera(pp.Origins([])),
    // Allow only the document's own origin.
    pp.Geolocation(pp.Origins([pp.Self])),
  ])),
)
```

See the [MDN docs][permissions].

</details>

<details>
<summary><code>Referrer-Policy</code></summary>

Default:

```
Referrer-Policy: no-referrer
```

Strips the `Referer` header from outgoing requests — the most private
option. Prevents leaking sensitive URL contents (session IDs, internal paths)
to third-party sites.

Customize via `plume/referrer_policy`:

```gleam
import gleam/option.{Some}
import plume
import plume/referrer_policy as rp

plume.Config(
  ..plume.new(),
  referrer_policy: Some(rp.NoReferrer),
)
```

To remove the header:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), referrer_policy: None)
```

See the [MDN docs][rp].

</details>

<details>
<summary><code>Strict-Transport-Security</code></summary>

Default:

```
Strict-Transport-Security: max-age=31536000; includeSubDomains
```

Tells browsers to access the site only over HTTPS for one year, including
subdomains. One year matches what browsers and the HSTS preload list expect,
and `includeSubDomains` stops an attacker who can intercept
`http://staging.example.com` from setting cookies for `example.com`.

`preload` is **not** included by default — submitting a domain to the preload
list is a deliberate, mostly-irreversible commitment that should be made
explicitly.

Customize via `plume/strict_transport_security`:

```gleam
import gleam/option.{Some}
import plume
import plume/strict_transport_security as sts

plume.Config(
  ..plume.new(),
  strict_transport_security: Some(sts.IncludeSubDomains(31_536_000)),
)
```

To remove the header:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), strict_transport_security: None)
```

See the [MDN docs][hsts].

</details>

<details>
<summary><code>X-Content-Type-Options</code></summary>

Default:

```
X-Content-Type-Options: nosniff
```

Disables MIME type sniffing, reducing exposure to drive-by download attacks
and the serving of user-uploaded content under an unexpected MIME type.

Enable via `plume/content_type_options`:

```gleam
import gleam/option.{Some}
import plume
import plume/content_type_options as cto

plume.Config(
  ..plume.new(),
  content_type_options: Some(cto.NoSniff),
)
```

To remove the header:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), content_type_options: None)
```

See the [MDN docs][xcto].

</details>

<details>
<summary><code>X-DNS-Prefetch-Control</code></summary>

Default:

```
X-DNS-Prefetch-Control: off
```

Disables DNS prefetching to avoid leaking which resources a page references
to the user's DNS resolver.

Customize via `plume/dns_prefetch_control`:

```gleam
import gleam/option.{Some}
import plume
import plume/dns_prefetch_control as dpc

plume.Config(
  ..plume.new(),
  dns_prefetch_control: Some(dpc.Off),
)
```

To remove the header:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), dns_prefetch_control: None)
```

See the [MDN docs][xdpc].

</details>

<details>
<summary><code>X-Download-Options</code></summary>

Default:

```
X-Download-Options: noopen
```

IE 8 only: forces downloaded files to be saved before opening, preventing
execution of HTML in the site's origin.

Enable via `plume/download_options`:

```gleam
import gleam/option.{Some}
import plume
import plume/download_options as do

plume.Config(
  ..plume.new(),
  download_options: Some(do.NoOpen),
)
```

To remove the header:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), download_options: None)
```

See the [Microsoft docs][xdo].

</details>

<details>
<summary><code>X-Frame-Options</code></summary>

Default:

```
X-Frame-Options: SAMEORIGIN
```

Restricts framing to same-origin pages, mitigating clickjacking. The CSP
`frame-ancestors` directive is the modern replacement; this header is kept
as a fallback for legacy browsers that don't honor `frame-ancestors`.

Customize via `plume/frame_options`:

```gleam
import gleam/option.{Some}
import plume
import plume/frame_options

plume.Config(
  ..plume.new(),
  frame_options: Some(frame_options.SameOrigin),
)
```

To remove the header:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), frame_options: None)
```

See the [MDN docs][xfo].

</details>

<details>
<summary><code>X-Permitted-Cross-Domain-Policies</code></summary>

Default:

```
X-Permitted-Cross-Domain-Policies: none
```

Blocks Adobe Flash and Acrobat cross-domain policy files from being loaded
on the site.

Customize via `plume/permitted_cross_domain_policies`:

```gleam
import gleam/option.{Some}
import plume
import plume/permitted_cross_domain_policies as pcdp

plume.Config(
  ..plume.new(),
  permitted_cross_domain_policies: Some(pcdp.None),
)
```

To remove the header:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), permitted_cross_domain_policies: None)
```

See the [MDN docs][xpcdp].

</details>

<details>
<summary><code>X-XSS-Protection</code></summary>

Default:

```
X-XSS-Protection: 0
```

Disables the legacy XSS auditor in older browsers — its bypasses could
become XSS sinks of their own, and modern browsers have removed it. A strong
`Content-Security-Policy` is the modern replacement, so the default of `0` is
the recommended value.

Customize via `plume/xss_protection`:

```gleam
import gleam/option.{Some}
import plume
import plume/xss_protection as xp

plume.Config(
  ..plume.new(),
  xss_protection: Some(xp.Disabled),
)
```

To remove the header:

```gleam
import gleam/option.{None}
import plume

plume.Config(..plume.default(), xss_protection: None)
```

See the [MDN docs][xxss].

</details>

[csp]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Security-Policy
[coep]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Cross-Origin-Embedder-Policy
[coop]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Cross-Origin-Opener-Policy
[corp]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Cross-Origin-Resource-Policy
[oac]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Origin-Agent-Cluster
[permissions]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Permissions-Policy
[rp]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Referrer-Policy
[hsts]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Strict-Transport-Security
[xcto]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Content-Type-Options
[xdpc]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-DNS-Prefetch-Control
[xdo]: https://learn.microsoft.com/en-us/archive/blogs/ie/ie8-security-part-v-comprehensive-protection
[xfo]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Frame-Options
[xpcdp]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Permitted-Cross-Domain-Policies
[xxss]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-XSS-Protection

## Interacting with other middleware

Plume sets every configured header, replacing any existing value. If you also
use Wisp's
[`content_security_policy_protection`](https://hexdocs.pm/wisp/wisp.html#content_security_policy_protection)
middleware — which emits a per-request nonce-based strict CSP — its header
will be overridden by Plume's CSP unless you either:

1. Place Wisp's CSP middleware **outside** Plume's so it runs last and wins
   on the `Content-Security-Policy` header:

    ```gleam
    import plume
    import wisp.{type Request, type Response}

    pub fn handle_request(_req: Request) -> Response {
      use _csp_nonce <- wisp.content_security_policy_protection()
      use <- plume.middleware(plume.default())
      wisp.ok()
    }
    ```

2. Or disable Plume's CSP so Wisp's is the only one set:

    ```gleam
    import gleam/option.{None}
    import plume

    plume.Config(..plume.default(), content_security_policy: None)
    ```

The same ordering rule applies to any other middleware that sets headers
Plume also configures.

## Development

```sh
gleam build  # Compile the project
gleam test   # Run the tests
```
