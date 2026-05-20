import plume/content_type_options as cto

pub fn to_header_test() {
  assert cto.to_string(cto.NoSniff) == "nosniff"
}
