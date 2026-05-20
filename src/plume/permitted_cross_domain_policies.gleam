//// X-Permitted-Cross-Domain-Policies
////
//// This response header tells clients (mainly Adobe Flash Player and Adobe
//// Acrobat) which cross-domain policy files (`crossdomain.xml`) are permitted
//// on the current site. Setting the header to `none` prevents any policy
//// files from being loaded, which is the most restrictive option.
////
//// See the [OWASP docs](https://owasp.org/www-project-secure-headers/#x-permitted-cross-domain-policies).

pub type PermittedCrossDomainPolicies {
  /// No policy files are allowed anywhere on the target server. Plume default.
  None
  /// Only the master policy file at `/crossdomain.xml` is allowed.
  MasterOnly
  /// Only policy files served with `Content-Type: text/x-cross-domain-policy`
  /// are allowed.
  ByContentType
  /// Only policy files whose filenames are `crossdomain.xml` are allowed. FTP
  /// only.
  ByFtpFilename
  /// All policy files on the target server are allowed.
  All
  /// No policy files are allowed, but only for the current response. Unlike
  /// `None`, this does not affect policies for other resources on the server.
  NoneThisResponse
}

pub fn to_string(value: PermittedCrossDomainPolicies) -> String {
  case value {
    None -> "none"
    MasterOnly -> "master-only"
    ByContentType -> "by-content-type"
    ByFtpFilename -> "by-ftp-filename"
    All -> "all"
    NoneThisResponse -> "none-this-response"
  }
}
