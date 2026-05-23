//// Strict-Transport-Security
////
//// This response header (often abbreviated as HSTS) lets a site tell browsers
//// that it should only be accessed using HTTPS, and that any future attempts
//// to access it using HTTP should be automatically converted to HTTPS. This
//// helps protect against protocol downgrade attacks and cookie hijacking.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Strict-Transport-Security).

import gleam/int

/// A `Strict-Transport-Security` header value.
///
pub type StrictTransportSecurity {
  /// Apply only to the current host, for `seconds` seconds. Use `MaxAge(0)`
  /// to clear a previously-set HSTS policy in browsers.
  MaxAge(seconds: Int)
  /// Apply to the current host and all subdomains, for `seconds` seconds.
  /// Plume default.
  IncludeSubDomains(seconds: Int)
  /// Apply to the current host and all subdomains, for `seconds` seconds, and
  /// signal consent to be included in browsers' HSTS preload lists.
  ///
  /// The preload list also requires `seconds` to be at least `31_536_000`
  /// (one year).
  Preload(seconds: Int)
}

/// Encode as the `Strict-Transport-Security` header value.
///
pub fn to_string(value: StrictTransportSecurity) -> String {
  case value {
    MaxAge(seconds) -> "max-age=" <> int.to_string(seconds)
    IncludeSubDomains(seconds) ->
      "max-age=" <> int.to_string(seconds) <> "; includeSubDomains"
    Preload(seconds) ->
      "max-age=" <> int.to_string(seconds) <> "; includeSubDomains; preload"
  }
}
