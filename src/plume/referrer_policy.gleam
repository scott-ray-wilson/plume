//// Referrer-Policy
////
//// This response header controls how much referrer information (sent via the
//// `Referer` header) should be included with requests made from a document.
//// Restricting referrer information helps protect user privacy and can prevent
//// leaking sensitive data contained in URLs (such as session identifiers or
//// internal paths) to third-party sites.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Referrer-Policy).

pub type ReferrerPolicy {
  /// The `Referer` header is omitted entirely. No referrer information is sent
  /// with requests. Plume default.
  NoReferrer
  /// Send the origin, path, and querystring when the protocol security level
  /// stays the same or improves (HTTP→HTTP, HTTP→HTTPS, HTTPS→HTTPS). Don't
  /// send the header for requests to less secure destinations (HTTPS→HTTP).
  NoReferrerWhenDowngrade
  /// Only send the origin of the document as the referrer.
  Origin
  /// Send the origin, path, and querystring for same-origin requests, but only
  /// the origin for cross-origin requests.
  OriginWhenCrossOrigin
  /// Send the origin, path, and querystring for same-origin requests. Don't
  /// send the header for cross-origin requests.
  SameOrigin
  /// Send only the origin when the protocol security level stays the same
  /// (HTTPS→HTTPS). Don't send the header to a less secure destination
  /// (HTTPS→HTTP).
  StrictOrigin
  /// Send the origin, path, and querystring for same-origin requests. Send
  /// only the origin for cross-origin requests when the protocol security
  /// level stays the same (HTTPS→HTTPS). Don't send the header to a less
  /// secure destination (HTTPS→HTTP). Browser default.
  StrictOriginWhenCrossOrigin
  /// Send the origin, path, and querystring with all requests regardless of
  /// security. This is unsafe — it may leak origins and paths from TLS-protected
  /// resources to insecure origins.
  UnsafeUrl
}

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
