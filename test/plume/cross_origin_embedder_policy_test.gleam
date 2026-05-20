import plume/cross_origin_embedder_policy as coep

pub fn to_header_test() {
  assert coep.to_string(coep.UnsafeNone) == "unsafe-none"
  assert coep.to_string(coep.RequireCorp) == "require-corp"
  assert coep.to_string(coep.Credentialless) == "credentialless"
}
