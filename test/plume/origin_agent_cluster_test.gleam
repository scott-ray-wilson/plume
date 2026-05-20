import plume/origin_agent_cluster as oac

pub fn to_header_test() {
  assert oac.to_string(oac.Enabled) == "?1"
  assert oac.to_string(oac.Disabled) == "?0"
}
