//// Content-Security-Policy (CSP)
////
//// This response header lets sites declare which resources the browser is
//// allowed to load for a given page, mitigating [cross-site scripting (XSS)](https://developer.mozilla.org/en-US/docs/Web/Security/Attacks/XSS)
//// and data-injection attacks. A policy is a list of directives separated
//// by `;`, where each directive (e.g. `script-src`, `style-src`) constrains
//// a particular resource type.
////
//// Plume ships a sensible starter policy by default; see `plume.default()`.
////
//// Most directives expect at least one value. Passing an empty list (e.g.
//// `DefaultSrc([])`) will render an incomplete directive that browsers may
//// treat as invalid — omit the directive entirely instead. `Sandbox([])` is
//// the exception; an empty sandbox token list applies the maximum
//// restrictions.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Security-Policy).

import gleam/list
import gleam/string

pub type ContentSecurityPolicy {
  Policy(List(Directive))
}

// TODO: SandboxStrict instead of Sandbox([])?
// TODO: how to handle empty directive lists? leads to an incomplete directive
// - we could strip, overwrite with 'none' or should we just let through?

pub type Directive {
  /// Serves as a fallback for the other fetch directives.
  DefaultSrc(List(Source))
  /// Valid sources for JavaScript and WebAssembly resources.
  ScriptSrc(List(Source))
  /// Valid sources for inline event handlers (e.g. `onclick`).
  ScriptSrcAttr(List(Source))
  /// Valid sources for JavaScript `<script>` elements.
  ScriptSrcElem(List(Source))
  /// Valid sources for stylesheets.
  StyleSrc(List(Source))
  /// Valid sources for inline styles applied to elements (e.g. `style`
  /// attributes).
  StyleSrcAttr(List(Source))
  /// Valid sources for stylesheet `<style>` elements and `<link>` elements
  /// with `rel="stylesheet"`.
  StyleSrcElem(List(Source))
  /// Valid sources of images and favicons.
  ImgSrc(List(Source))
  /// Restricts the URLs which can be loaded using script interfaces.
  ConnectSrc(List(Source))
  /// Valid sources for fonts loaded using `@font-face`.
  FontSrc(List(Source))
  /// Valid sources for the `<object>` and `<embed>` elements.
  ObjectSrc(List(Source))
  /// Valid sources for loading media using the `<audio>`, `<video>` and
  /// `<track>` elements.
  MediaSrc(List(Source))
  /// Valid sources for nested browsing contexts loaded into elements such as
  /// `<frame>` and `<iframe>`.
  FrameSrc(List(Source))
  /// Valid sources for nested browsing contexts loaded into `<fencedframe>`
  /// elements. Does not fall back to `default-src` or `frame-src`; if
  /// omitted, any URL is allowed.
  FencedFrameSrc(List(Source))
  /// Valid parents that may embed a page using `<frame>`, `<iframe>`,
  /// `<object>`, or `<embed>`.
  FrameAncestors(List(Source))
  /// Valid sources for web workers and nested browsing contexts loaded using
  /// elements such as `<frame>` and `<iframe>`. Falls back to `default-src`.
  ChildSrc(List(Source))
  /// Valid sources for application manifest files.
  ManifestSrc(List(Source))
  /// Valid sources for `Worker`, `SharedWorker`, or `ServiceWorker` scripts.
  WorkerSrc(List(Source))
  /// Restricts the URLs which can be used in a document's `<base>` element.
  BaseUri(List(Source))
  /// Restricts the URLs which can be used as the target of form submissions.
  FormAction(List(Source))
  /// Enables a sandbox for the requested resource, similar to the `<iframe>`
  /// `sandbox` attribute. Pass an empty list to apply the maximum
  /// restrictions.
  Sandbox(List(SandboxToken))
  /// URIs that the browser should send violation reports to. Deprecated in
  /// favor of `report-to` but still widely supported.
  ReportUri(List(String))
  /// Names a reporting group defined via the `Reporting-Endpoints` header
  /// that violation reports should be sent to.
  ReportTo(String)
  /// Instructs the browser to upgrade insecure requests (HTTP) to secure
  /// requests (HTTPS) before fetching.
  UpgradeInsecureRequests
  /// Instructs user agents to control the data passed to DOM XSS sink
  /// functions, like the `Element.innerHTML` setter.
  RequireTrustedTypesFor(List(TrustedTypesSink))
  /// Restricts which Trusted Types policies may be created and used by
  /// scripts.
  TrustedTypes(List(TrustedTypePolicy))
}

pub type Source {
  /// Refers to the origin from which the protected document is being served,
  /// including the same URL scheme and port number. Rendered as `'self'`.
  Self
  /// Refers to the empty set; that is, no URLs match. Rendered as `'none'`.
  None
  /// Allows the use of inline resources such as inline `<script>` elements,
  /// `javascript:` URLs, and inline event handlers. Rendered as
  /// `'unsafe-inline'`.
  UnsafeInline
  /// Allows the use of `eval()` and similar methods for creating code from
  /// strings. Rendered as `'unsafe-eval'`.
  UnsafeEval
  /// Specifies that the trust explicitly given to a script present in the
  /// markup, by accompanying it with a nonce or a hash, shall be propagated
  /// to all the scripts loaded by that root script. Rendered as
  /// `'strict-dynamic'`.
  StrictDynamic
  /// Allows the loading and execution of WebAssembly modules without
  /// needing to also allow `'unsafe-eval'`. Rendered as
  /// `'wasm-unsafe-eval'`.
  WasmUnsafeEval
  /// Allows hashes (e.g. `'sha256-...'`) to match against inline event
  /// handlers and `style` attributes, which are otherwise excluded from
  /// hash matching. Rendered as `'unsafe-hashes'`.
  UnsafeHashes
  /// Requires that violation reports include a sample of the offending
  /// resource. Rendered as `'report-sample'`.
  ReportSample
  /// Allows inline `<script type="speculationrules">` blocks used by the
  /// Speculation Rules API. Rendered as `'inline-speculation-rules'`.
  InlineSpeculationRules
  /// Matches any URL, except those with the `data:`, `blob:`, or
  /// `filesystem:` schemes. Rendered as `*`.
  Wildcard
  /// A host source, e.g. `https://cdn.example.com` or `*.example.com`.
  Host(String)
  /// A scheme source, e.g. `"https"` (rendered as `https:`). Pass the scheme
  /// name without the trailing colon.
  Scheme(String)
  /// A base64-encoded nonce that matches the `nonce` attribute on an inline
  /// element. Rendered as `'nonce-<value>'`.
  Nonce(String)
  /// A base64-encoded SHA-256 hash of an inline resource. Rendered as
  /// `'sha256-<value>'`.
  Sha256(String)
  /// A base64-encoded SHA-384 hash of an inline resource. Rendered as
  /// `'sha384-<value>'`.
  Sha384(String)
  /// A base64-encoded SHA-512 hash of an inline resource. Rendered as
  /// `'sha512-<value>'`.
  Sha512(String)
}

pub type TrustedTypesSink {
  /// The DOM XSS injection sink group. The only sink group currently defined
  /// by the spec. Rendered as `'script'`.
  Script
}

pub type TrustedTypePolicy {
  /// A policy name that may be created (e.g. `default`, `dompurify`).
  PolicyName(String)
  /// Allows the same policy name to be created more than once. Rendered as
  /// `'allow-duplicates'`.
  AllowDuplicates
  /// Disables Trusted Types policy creation entirely. Rendered as `'none'`.
  NoPolicy
  /// Allows any policy name. Rendered as `*`.
  AnyPolicy
}

pub type SandboxToken {
  /// Allows downloads to be initiated by the sandboxed content.
  AllowDownloads
  /// Allows the content to submit forms.
  AllowForms
  /// Allows the content to open modal dialogs (e.g. `alert()`, `confirm()`,
  /// `prompt()`, `print()`).
  AllowModals
  /// Allows the content to disable the ability to lock the screen
  /// orientation.
  AllowOrientationLock
  /// Allows the content to use the Pointer Lock API.
  AllowPointerLock
  /// Allows the content to open popups (e.g. `window.open()`, `target="_blank"`).
  AllowPopups
  /// Allows popups opened by the sandboxed content to escape the sandbox,
  /// rather than inheriting its restrictions.
  AllowPopupsToEscapeSandbox
  /// Allows the content to start a presentation session.
  AllowPresentation
  /// Treats the content as being from its normal origin rather than a
  /// unique opaque origin, allowing access to same-origin data such as
  /// cookies and storage.
  AllowSameOrigin
  /// Allows the content to execute scripts.
  AllowScripts
  /// Allows the content to navigate the top-level browsing context.
  AllowTopNavigation
  /// Allows the content to navigate the top-level browsing context, but
  /// only in response to a user gesture.
  AllowTopNavigationByUserActivation
  /// Allows the content to navigate the top-level browsing context to
  /// non-`http`/`https` URL schemes.
  AllowTopNavigationToCustomProtocols
}

pub fn to_string(value: ContentSecurityPolicy) -> String {
  let Policy(directives) = value
  directives
  |> list.map(directive_to_string)
  |> string.join("; ")
}

fn directive_to_string(directive: Directive) -> String {
  case directive {
    DefaultSrc(sources) -> render_sources("default-src", sources)
    ScriptSrc(sources) -> render_sources("script-src", sources)
    ScriptSrcAttr(sources) -> render_sources("script-src-attr", sources)
    ScriptSrcElem(sources) -> render_sources("script-src-elem", sources)
    StyleSrc(sources) -> render_sources("style-src", sources)
    StyleSrcAttr(sources) -> render_sources("style-src-attr", sources)
    StyleSrcElem(sources) -> render_sources("style-src-elem", sources)
    ImgSrc(sources) -> render_sources("img-src", sources)
    ConnectSrc(sources) -> render_sources("connect-src", sources)
    FontSrc(sources) -> render_sources("font-src", sources)
    ObjectSrc(sources) -> render_sources("object-src", sources)
    MediaSrc(sources) -> render_sources("media-src", sources)
    FrameSrc(sources) -> render_sources("frame-src", sources)
    FencedFrameSrc(sources) -> render_sources("fenced-frame-src", sources)
    FrameAncestors(sources) -> render_sources("frame-ancestors", sources)
    ChildSrc(sources) -> render_sources("child-src", sources)
    ManifestSrc(sources) -> render_sources("manifest-src", sources)
    WorkerSrc(sources) -> render_sources("worker-src", sources)
    BaseUri(sources) -> render_sources("base-uri", sources)
    FormAction(sources) -> render_sources("form-action", sources)
    Sandbox(tokens) -> render_tokens("sandbox", tokens)
    ReportUri(uris) -> string.join(["report-uri", ..uris], " ")
    ReportTo(group) -> "report-to " <> group
    UpgradeInsecureRequests -> "upgrade-insecure-requests"
    RequireTrustedTypesFor(sinks) ->
      string.join(
        [
          "require-trusted-types-for",
          ..list.map(sinks, trusted_types_sink_to_string)
        ],
        " ",
      )
    TrustedTypes(policies) ->
      string.join(
        ["trusted-types", ..list.map(policies, trusted_type_policy_to_string)],
        " ",
      )
  }
}

fn render_sources(name: String, sources: List(Source)) -> String {
  string.join([name, ..list.map(sources, source_to_string)], " ")
}

fn render_tokens(name: String, tokens: List(SandboxToken)) -> String {
  string.join([name, ..list.map(tokens, sandbox_token_to_string)], " ")
}

fn source_to_string(source: Source) -> String {
  case source {
    Self -> "'self'"
    None -> "'none'"
    UnsafeInline -> "'unsafe-inline'"
    UnsafeEval -> "'unsafe-eval'"
    StrictDynamic -> "'strict-dynamic'"
    WasmUnsafeEval -> "'wasm-unsafe-eval'"
    UnsafeHashes -> "'unsafe-hashes'"
    ReportSample -> "'report-sample'"
    InlineSpeculationRules -> "'inline-speculation-rules'"
    Wildcard -> "*"
    Host(value) -> value
    Scheme(value) -> value <> ":"
    Nonce(value) -> "'nonce-" <> value <> "'"
    Sha256(value) -> "'sha256-" <> value <> "'"
    Sha384(value) -> "'sha384-" <> value <> "'"
    Sha512(value) -> "'sha512-" <> value <> "'"
  }
}

fn trusted_types_sink_to_string(sink: TrustedTypesSink) -> String {
  case sink {
    Script -> "'script'"
  }
}

fn trusted_type_policy_to_string(policy: TrustedTypePolicy) -> String {
  case policy {
    PolicyName(name) -> name
    AllowDuplicates -> "'allow-duplicates'"
    NoPolicy -> "'none'"
    AnyPolicy -> "*"
  }
}

fn sandbox_token_to_string(token: SandboxToken) -> String {
  case token {
    AllowDownloads -> "allow-downloads"
    AllowForms -> "allow-forms"
    AllowModals -> "allow-modals"
    AllowOrientationLock -> "allow-orientation-lock"
    AllowPointerLock -> "allow-pointer-lock"
    AllowPopups -> "allow-popups"
    AllowPopupsToEscapeSandbox -> "allow-popups-to-escape-sandbox"
    AllowPresentation -> "allow-presentation"
    AllowSameOrigin -> "allow-same-origin"
    AllowScripts -> "allow-scripts"
    AllowTopNavigation -> "allow-top-navigation"
    AllowTopNavigationByUserActivation ->
      "allow-top-navigation-by-user-activation"
    AllowTopNavigationToCustomProtocols ->
      "allow-top-navigation-to-custom-protocols"
  }
}
