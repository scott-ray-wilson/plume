//// Cross-Origin Opener Policy (COOP)
////
//// This response header controls whether a top-level document shares a
//// browsing context group with cross-origin documents that open it or that
//// it opens. Required alongside `Cross-Origin-Embedder-Policy` to enable
//// cross-origin isolation.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Cross-Origin-Opener-Policy).

/// A `Cross-Origin-Opener-Policy` header value.
///
pub type CrossOriginOpenerPolicy {
  /// Allows the document to share a browsing context group with its opener.
  /// Browser default.
  UnsafeNone
  /// Isolates the browsing context to same-origin documents. Plume default.
  SameOrigin
  /// Like `SameOrigin`, but keeps references to popups that either don't set
  /// the header or set it to `UnsafeNone`.
  SameOriginAllowPopups
  /// Newly-opened cross-origin documents are loaded in a new browsing
  /// context group. Same-origin documents, and cross-origin documents not
  /// opened from this one, are unaffected.
  NoopenerAllowPopups
}

/// Encode as the `Cross-Origin-Opener-Policy` header value.
///
pub fn to_string(value: CrossOriginOpenerPolicy) -> String {
  case value {
    UnsafeNone -> "unsafe-none"
    SameOrigin -> "same-origin"
    SameOriginAllowPopups -> "same-origin-allow-popups"
    NoopenerAllowPopups -> "noopener-allow-popups"
  }
}
