//// Origin-Agent-Cluster
////
//// This response header requests that the associated document be placed in an
//// origin-keyed [agent cluster](https://tc39.es/ecma262/#sec-agent-clusters),
//// isolating it from other documents that share its
//// [site](https://developer.mozilla.org/en-US/docs/Glossary/Site) but not its
//// [origin](https://developer.mozilla.org/en-US/docs/Glossary/Origin). This
//// prevents synchronous scripting access between same-site cross-origin
//// documents and may allow the browser to allocate the origin its own process
//// or thread.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Origin-Agent-Cluster).

pub type OriginAgentCluster {
  /// Requests origin-keyed agent clustering. Plume default.
  Enabled
  /// Requests site-keyed agent clustering. Browser default.
  Disabled
}

pub fn to_string(value: OriginAgentCluster) -> String {
  case value {
    Enabled -> "?1"
    Disabled -> "?0"
  }
}
