//// X-Frame-Options
////
//// This response header indicates whether a browser should be allowed to
//// render a page in a `<frame>`, `<iframe>`, `<embed>` or `<object>`. Sites
//// can use this to avoid [click-jacking](https://developer.mozilla.org/en-US/docs/Web/Security/Attacks/Clickjacking)
//// attacks by ensuring that their content is not embedded into other sites.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Frame-Options).

/// An `X-Frame-Options` header value.
///
pub type FrameOptions {
  /// The page cannot be displayed in a frame, regardless of the site
  /// attempting to do so.
  Deny
  /// The page can only be displayed in a frame on the same origin as the
  /// page itself. Plume default.
  SameOrigin
}

/// Encode as the `X-Frame-Options` header value.
///
pub fn to_string(value: FrameOptions) -> String {
  case value {
    Deny -> "DENY"
    SameOrigin -> "SAMEORIGIN"
  }
}
