//// Cross-Origin Resource Policy (CORP)
////
//// This response header determines which origins are allowed to
//// read no-cors resource responses (e.g. those triggered by `<script>` and `<img>`).
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Cross-Origin_Resource_Policy).

pub type CrossOriginResourcePolicy {
  /// Restricts reads to requests originating from the same
  /// [site](https://developer.mozilla.org/en-US/docs/Glossary/Site), matched by
  /// registrable domain. Less secure than `SameOrigin`.
  SameSite
  /// Restricts reads to requests sharing the same [origin](https://developer.mozilla.org/en-US/docs/Glossary/Origin) (same scheme, host, and port). Plume default.
  SameOrigin
  /// Permits reads from any [origin](https://developer.mozilla.org/en-US/docs/Glossary/Origin). Useful when paired with
  /// [Cross-Origin Embedder Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Cross-Origin-Embedder-Policy).
  CrossOrigin
}

pub fn to_string(value: CrossOriginResourcePolicy) -> String {
  case value {
    SameSite -> "same-site"
    SameOrigin -> "same-origin"
    CrossOrigin -> "cross-origin"
  }
}
