//// Cross-Origin Embedder Policy (COEP)
////
//// This response header controls whether a document can load cross-origin
//// resources that don't explicitly grant permission via CORS or
//// `Cross-Origin-Resource-Policy`. Required alongside
//// `Cross-Origin-Opener-Policy` to enable cross-origin isolation. Not
//// configured by default.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Cross-Origin-Embedder-Policy).

/// A `Cross-Origin-Embedder-Policy` header value.
///
pub type CrossOriginEmbedderPolicy {
  /// Allows the document to fetch cross-origin resources without explicit
  /// permission. Browser default.
  UnsafeNone
  /// Restricts the document to same-origin resources and cross-origin
  /// resources that explicitly grant permission.
  RequireCorp
  /// Like `RequireCorp`, but no-cors cross-origin requests are sent without
  /// credentials.
  Credentialless
}

/// Encode as the `Cross-Origin-Embedder-Policy` header value.
///
pub fn to_string(value: CrossOriginEmbedderPolicy) -> String {
  case value {
    UnsafeNone -> "unsafe-none"
    RequireCorp -> "require-corp"
    Credentialless -> "credentialless"
  }
}
