import plume/cross_origin_resource_policy as corp

pub fn to_header_test() {
  assert corp.to_string(corp.SameSite) == "same-site"
  assert corp.to_string(corp.SameOrigin) == "same-origin"
  assert corp.to_string(corp.CrossOrigin) == "cross-origin"
}
