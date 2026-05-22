import plume/content_security_policy as csp

pub fn to_header_empty_test() {
  assert csp.to_string(csp.Policy([])) == ""
}

pub fn to_header_join_test() {
  assert csp.to_string(
      csp.Policy([
        csp.DefaultSrc([csp.None]),
        csp.ScriptSrc([csp.Self, csp.Nonce("abc123")]),
      ]),
    )
    == "default-src 'none'; script-src 'self' 'nonce-abc123'"
}

pub fn directive_to_header_test() {
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.Self])]))
    == "default-src 'self'"
  assert csp.to_string(csp.Policy([csp.ScriptSrc([csp.Self])]))
    == "script-src 'self'"
  assert csp.to_string(csp.Policy([csp.ScriptSrcAttr([csp.None])]))
    == "script-src-attr 'none'"
  assert csp.to_string(csp.Policy([csp.ScriptSrcElem([csp.Self])]))
    == "script-src-elem 'self'"
  assert csp.to_string(csp.Policy([csp.StyleSrc([csp.Self])]))
    == "style-src 'self'"
  assert csp.to_string(csp.Policy([csp.StyleSrcAttr([csp.None])]))
    == "style-src-attr 'none'"
  assert csp.to_string(csp.Policy([csp.StyleSrcElem([csp.Self])]))
    == "style-src-elem 'self'"
  assert csp.to_string(csp.Policy([csp.ImgSrc([csp.Self])])) == "img-src 'self'"
  assert csp.to_string(csp.Policy([csp.ConnectSrc([csp.Self])]))
    == "connect-src 'self'"
  assert csp.to_string(csp.Policy([csp.FontSrc([csp.Self])]))
    == "font-src 'self'"
  assert csp.to_string(csp.Policy([csp.ObjectSrc([csp.None])]))
    == "object-src 'none'"
  assert csp.to_string(csp.Policy([csp.MediaSrc([csp.Self])]))
    == "media-src 'self'"
  assert csp.to_string(csp.Policy([csp.FrameSrc([csp.Self])]))
    == "frame-src 'self'"
  assert csp.to_string(csp.Policy([csp.FencedFrameSrc([csp.Self])]))
    == "fenced-frame-src 'self'"
  assert csp.to_string(csp.Policy([csp.FrameAncestors([csp.None])]))
    == "frame-ancestors 'none'"
  assert csp.to_string(csp.Policy([csp.ChildSrc([csp.Self])]))
    == "child-src 'self'"
  assert csp.to_string(csp.Policy([csp.ManifestSrc([csp.Self])]))
    == "manifest-src 'self'"
  assert csp.to_string(csp.Policy([csp.WorkerSrc([csp.Self])]))
    == "worker-src 'self'"
  assert csp.to_string(csp.Policy([csp.BaseUri([csp.Self])]))
    == "base-uri 'self'"
  assert csp.to_string(csp.Policy([csp.FormAction([csp.Self])]))
    == "form-action 'self'"
  assert csp.to_string(csp.Policy([csp.UpgradeInsecureRequests]))
    == "upgrade-insecure-requests"
  assert csp.to_string(csp.Policy([csp.RequireTrustedTypesFor([csp.Script])]))
    == "require-trusted-types-for 'script'"
  assert csp.to_string(
      csp.Policy([csp.TrustedTypes([csp.PolicyName("dompurify")])]),
    )
    == "trusted-types dompurify"
  assert csp.to_string(
      csp.Policy([
        csp.TrustedTypes([
          csp.PolicyName("default"),
          csp.PolicyName("dompurify"),
          csp.AllowDuplicates,
        ]),
      ]),
    )
    == "trusted-types default dompurify 'allow-duplicates'"
  assert csp.to_string(csp.Policy([csp.TrustedTypes([csp.NoPolicy])]))
    == "trusted-types 'none'"
  assert csp.to_string(csp.Policy([csp.TrustedTypes([csp.AnyPolicy])]))
    == "trusted-types *"
}

pub fn source_to_header_test() {
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.Self])]))
    == "default-src 'self'"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.None])]))
    == "default-src 'none'"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.UnsafeInline])]))
    == "default-src 'unsafe-inline'"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.UnsafeEval])]))
    == "default-src 'unsafe-eval'"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.StrictDynamic])]))
    == "default-src 'strict-dynamic'"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.WasmUnsafeEval])]))
    == "default-src 'wasm-unsafe-eval'"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.UnsafeHashes])]))
    == "default-src 'unsafe-hashes'"
  assert csp.to_string(
      csp.Policy([csp.DefaultSrc([csp.InlineSpeculationRules])]),
    )
    == "default-src 'inline-speculation-rules'"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.Wildcard])]))
    == "default-src *"
  assert csp.to_string(
      csp.Policy([csp.DefaultSrc([csp.Host("https://cdn.example.com")])]),
    )
    == "default-src https://cdn.example.com"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.Scheme("data")])]))
    == "default-src data:"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.Scheme("https")])]))
    == "default-src https:"
  assert csp.to_string(
      csp.Policy([csp.DefaultSrc([csp.Scheme("chrome-extension")])]),
    )
    == "default-src chrome-extension:"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.Nonce("abc123")])]))
    == "default-src 'nonce-abc123'"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.Sha256("hash256")])]))
    == "default-src 'sha256-hash256'"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.Sha384("hash384")])]))
    == "default-src 'sha384-hash384'"
  assert csp.to_string(csp.Policy([csp.DefaultSrc([csp.Sha512("hash512")])]))
    == "default-src 'sha512-hash512'"
}

pub fn sandbox_test() {
  assert csp.to_string(csp.Policy([csp.Sandbox([])])) == "sandbox"
  assert csp.to_string(
      csp.Policy([csp.Sandbox([csp.AllowScripts, csp.AllowSameOrigin])]),
    )
    == "sandbox allow-scripts allow-same-origin"
  assert csp.to_string(csp.Policy([csp.Sandbox([csp.AllowDownloads])]))
    == "sandbox allow-downloads"
  assert csp.to_string(csp.Policy([csp.Sandbox([csp.AllowForms])]))
    == "sandbox allow-forms"
  assert csp.to_string(csp.Policy([csp.Sandbox([csp.AllowModals])]))
    == "sandbox allow-modals"
  assert csp.to_string(csp.Policy([csp.Sandbox([csp.AllowOrientationLock])]))
    == "sandbox allow-orientation-lock"
  assert csp.to_string(csp.Policy([csp.Sandbox([csp.AllowPointerLock])]))
    == "sandbox allow-pointer-lock"
  assert csp.to_string(csp.Policy([csp.Sandbox([csp.AllowPopups])]))
    == "sandbox allow-popups"
  assert csp.to_string(
      csp.Policy([csp.Sandbox([csp.AllowPopupsToEscapeSandbox])]),
    )
    == "sandbox allow-popups-to-escape-sandbox"
  assert csp.to_string(csp.Policy([csp.Sandbox([csp.AllowPresentation])]))
    == "sandbox allow-presentation"
  assert csp.to_string(csp.Policy([csp.Sandbox([csp.AllowTopNavigation])]))
    == "sandbox allow-top-navigation"
  assert csp.to_string(
      csp.Policy([csp.Sandbox([csp.AllowTopNavigationByUserActivation])]),
    )
    == "sandbox allow-top-navigation-by-user-activation"
  assert csp.to_string(
      csp.Policy([csp.Sandbox([csp.AllowTopNavigationToCustomProtocols])]),
    )
    == "sandbox allow-top-navigation-to-custom-protocols"
}

pub fn multi_source_test() {
  assert csp.to_string(
      csp.Policy([
        csp.ScriptSrc([
          csp.Self,
          csp.Host("https://cdn.example.com"),
          csp.Nonce("abc"),
        ]),
      ]),
    )
    == "script-src 'self' https://cdn.example.com 'nonce-abc'"
}
