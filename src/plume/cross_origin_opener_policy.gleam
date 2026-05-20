//// Cross-Origin Opener Policy (COOP)
////
//// This response header controls whether a top-level document shares a
//// [browsing context group](https://developer.mozilla.org/en-US/docs/Glossary/Browsing_context) with cross-origin documents that open it or that it opens.
////
//// Required, alongside `Cross-Origin-Embedder-Policy`,
//// to enable [cross-origin isolation](https://developer.mozilla.org/en-US/docs/Web/API/Window/crossOriginIsolated).
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Cross-Origin-Opener-Policy).

pub type CrossOriginOpenerPolicy {
  /// Allows the document to be added to its opener's browsing context group
  /// unless the opener itself has a Cross-Origin Opener Policy of `SameOrigin` or `SameOriginAllowPopups`. Browser default.
  UnsafeNone
  /// Isolates the browsing context to [same-origin](https://developer.mozilla.org/en-US/docs/Glossary/Origin) documents.
  /// Cross-origin documents are not loaded in the same browsing context group. Plume default.
  SameOrigin
  /// Like `SameOrigin`, but keeps references to popups that either don't
  /// set Cross-Origin Opener Policy or set it to `UnsafeNone`.
  SameOriginAllowPopups
  /// Newly-opened cross-origin documents are loaded in a new browsing context group.
  /// Same-origin documents, and cross-origin documents not opened from the document
  /// with this header, are not affected.
  NoopenerAllowPopups
}

pub fn to_string(policy: CrossOriginOpenerPolicy) -> String {
  case policy {
    UnsafeNone -> "unsafe-none"
    SameOrigin -> "same-origin"
    SameOriginAllowPopups -> "same-origin-allow-popups"
    NoopenerAllowPopups -> "noopener-allow-popups"
  }
}
