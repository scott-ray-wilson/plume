import plume/xss_protection as xp

pub fn to_header_test() {
  assert xp.to_string(xp.Disabled) == "0"
  assert xp.to_string(xp.Enabled) == "1"
  assert xp.to_string(xp.Block) == "1; mode=block"
}
