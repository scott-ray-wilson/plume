//// Cross-Origin Resource Policy (CORP)
////
//// This response header determines which origins are allowed to
//// read no-cors resource responses (e.g. those triggered by `<script>` and `<img>`).
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Cross-Origin_Resource_Policy).

/// A `Cross-Origin-Resource-Policy` header value.
///
pub type CrossOriginResourcePolicy {
  /// Restricts reads to requests from the same site (matched by registrable
  /// domain). Less secure than `SameOrigin`.
  SameSite
  /// Restricts reads to requests sharing the same origin (same scheme,
  /// host, and port). Plume default.
  SameOrigin
  /// Permits reads from any origin. Useful when paired with
  /// `Cross-Origin-Embedder-Policy`.
  CrossOrigin
}

/// Encode as the `Cross-Origin-Resource-Policy` header value.
///
pub fn to_string(value: CrossOriginResourcePolicy) -> String {
  case value {
    SameSite -> "same-site"
    SameOrigin -> "same-origin"
    CrossOrigin -> "cross-origin"
  }
}
