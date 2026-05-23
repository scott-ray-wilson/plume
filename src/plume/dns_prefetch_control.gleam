//// X-DNS-Prefetch-Control
////
//// This response header controls DNS prefetching, a feature by which browsers
//// proactively perform domain name resolution on links, images, CSS, and other
//// resources the user may navigate to. Prefetching improves performance but
//// can leak information about which resources a page references to the user's
//// DNS resolver.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-DNS-Prefetch-Control).

/// An `X-DNS-Prefetch-Control` header value.
///
pub type DnsPrefetchControl {
  /// Enables DNS prefetching.
  On
  /// Disables DNS prefetching. Plume default.
  Off
}

/// Encode as the `X-DNS-Prefetch-Control` header value.
///
pub fn to_string(value: DnsPrefetchControl) -> String {
  case value {
    On -> "on"
    Off -> "off"
  }
}
