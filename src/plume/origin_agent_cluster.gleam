pub type OriginAgentCluster {
  Enabled
  Disabled
}

pub fn to_string(value: OriginAgentCluster) -> String {
  case value {
    Enabled -> "?1"
    Disabled -> "?0"
  }
}
