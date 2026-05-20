//// Cross-Origin Embedder Policy (COEP)
////
//// This response header controls whether a document can load cross-origin
//// resources that don't explicitly grant permission (via [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CORS) or
//// [CORP](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Cross-Origin_Resource_Policy)).
////
//// Required, alongside `Cross-Origin-Opener-Policy`,
//// to enable [cross-origin isolation](https://developer.mozilla.org/en-US/docs/Web/API/Window/crossOriginIsolated).
////
////  Not configured by default.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Cross-Origin-Embedder-Policy).

// TODO: explore supporting report-to

pub type CrossOriginEmbedderPolicy {
  /// Allows the document to fetch cross-origin resources without
  /// explicit permission via [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CORS) or
  /// [Cross-Origin Resource Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Cross-Origin_Resource_Policy). Browser default.
  UnsafeNone
  /// Restricts the document to loading [same-origin](https://developer.mozilla.org/en-US/docs/Glossary/Origin) resources
  /// and cross-origin resources that explicitly grant permission via [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CORS) or
  /// [Cross-Origin Resource Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Cross-Origin_Resource_Policy).
  RequireCorp
  /// Like `RequireCorp`, but no-cors cross-origin requests are sent
  /// without credentials (cookies are omitted from the request and ignored in the response).
  Credentialless
}

pub fn to_string(policy: CrossOriginEmbedderPolicy) -> String {
  case policy {
    UnsafeNone -> "unsafe-none"
    RequireCorp -> "require-corp"
    Credentialless -> "credentialless"
  }
}
