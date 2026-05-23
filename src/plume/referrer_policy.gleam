//// Referrer-Policy
////
//// This response header controls how much referrer information (sent via the
//// `Referer` header) should be included with requests made from a document.
//// Restricting referrer information helps protect user privacy and can prevent
//// leaking sensitive data contained in URLs (such as session identifiers or
//// internal paths) to third-party sites.
////
//// In the descriptions below, "full URL" refers to the origin, path, and
//// query string; the fragment is always stripped from the `Referer` header.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Referrer-Policy).

/// A `Referrer-Policy` header value.
///
pub type ReferrerPolicy {
  /// Omit the `Referer` header entirely. Plume default.
  NoReferrer
  /// Send the full URL except when downgrading from HTTPS to HTTP.
  NoReferrerWhenDowngrade
  /// Send only the document's origin.
  Origin
  /// Send the full URL for same-origin requests, just the origin for
  /// cross-origin requests.
  OriginWhenCrossOrigin
  /// Send the full URL for same-origin requests; omit the header for
  /// cross-origin requests.
  SameOrigin
  /// Send only the origin, and omit the header on HTTPS→HTTP downgrades.
  StrictOrigin
  /// Send the full URL for same-origin, just the origin for cross-origin,
  /// and omit the header on HTTPS→HTTP downgrades. Browser default.
  StrictOriginWhenCrossOrigin
  /// Send the full URL with every request. Unsafe — may leak URLs from
  /// TLS-protected resources to insecure origins.
  UnsafeUrl
}

/// Encode as the `Referrer-Policy` header value.
///
pub fn to_string(value: ReferrerPolicy) -> String {
  case value {
    NoReferrer -> "no-referrer"
    NoReferrerWhenDowngrade -> "no-referrer-when-downgrade"
    Origin -> "origin"
    OriginWhenCrossOrigin -> "origin-when-cross-origin"
    SameOrigin -> "same-origin"
    StrictOrigin -> "strict-origin"
    StrictOriginWhenCrossOrigin -> "strict-origin-when-cross-origin"
    UnsafeUrl -> "unsafe-url"
  }
}
