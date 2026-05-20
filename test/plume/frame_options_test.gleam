import plume/frame_options as fo

pub fn to_header_test() {
  assert fo.to_string(fo.Deny) == "DENY"
  assert fo.to_string(fo.SameOrigin) == "SAMEORIGIN"
}
