//// Origin-Agent-Cluster
////
//// This response header requests that the document be placed in an
//// origin-keyed agent cluster, isolating it from other same-site
//// cross-origin documents. This prevents synchronous scripting access
//// between them and may let the browser give the origin its own process
//// or thread.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Origin-Agent-Cluster).

/// An `Origin-Agent-Cluster` header value.
///
pub type OriginAgentCluster {
  /// Requests origin-keyed agent clustering. Plume default.
  Enabled
  /// Requests site-keyed agent clustering. Browser default.
  Disabled
}

/// Encode as the `Origin-Agent-Cluster` header value.
///
pub fn to_string(value: OriginAgentCluster) -> String {
  case value {
    Enabled -> "?1"
    Disabled -> "?0"
  }
}
