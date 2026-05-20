//// X-XSS-Protection
////
//// This response header was a feature of Internet Explorer, Chrome and Safari
//// that stopped pages from loading when they detected reflected cross-site
//// scripting (XSS) attacks. These protections are largely unnecessary in
//// modern browsers when sites implement a strong [Content-Security-Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Security-Policy)
//// that disables the use of inline JavaScript. Setting the header to `0` is
//// recommended to disable the buggy XSS auditor that older browsers may still
//// ship with.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-XSS-Protection).

pub type XssProtection {
  /// Disables XSS filtering. Plume default.
  Disabled
  /// Enables XSS filtering. If an attack is detected, the browser will
  /// sanitize the page.
  Enabled
  /// Enables XSS filtering. If an attack is detected, the browser will
  /// prevent rendering of the page rather than sanitizing it.
  Block
}

pub fn to_string(value: XssProtection) -> String {
  case value {
    Disabled -> "0"
    Enabled -> "1"
    Block -> "1; mode=block"
  }
}
