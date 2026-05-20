import plume/download_options as do

pub fn to_header_test() {
  assert do.to_string(do.NoOpen) == "noopen"
}
