import plume/strict_transport_security as sts

pub fn to_header_test() {
  assert sts.to_string(sts.MaxAge(0)) == "max-age=0"
  assert sts.to_string(sts.IncludeSubDomains(15_552_000))
    == "max-age=15552000; includeSubDomains"
  assert sts.to_string(sts.Preload(31_536_000))
    == "max-age=31536000; includeSubDomains; preload"
}
