import plume/permitted_cross_domain_policies as pcdp

pub fn to_header_test() {
  assert pcdp.to_string(pcdp.None) == "none"
  assert pcdp.to_string(pcdp.MasterOnly) == "master-only"
  assert pcdp.to_string(pcdp.ByContentType) == "by-content-type"
  assert pcdp.to_string(pcdp.ByFtpFilename) == "by-ftp-filename"
  assert pcdp.to_string(pcdp.All) == "all"
  assert pcdp.to_string(pcdp.NoneThisResponse) == "none-this-response"
}
