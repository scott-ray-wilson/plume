import plume/cross_origin_opener_policy as coop

pub fn to_header_test() {
  assert coop.to_string(coop.UnsafeNone) == "unsafe-none"
  assert coop.to_string(coop.SameOrigin) == "same-origin"
  assert coop.to_string(coop.SameOriginAllowPopups)
    == "same-origin-allow-popups"
  assert coop.to_string(coop.NoopenerAllowPopups) == "noopener-allow-popups"
}
