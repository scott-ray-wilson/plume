//// X-Download-Options
////
//// This response header is specific to Internet Explorer 8. It instructs the
//// browser to not open a downloaded file directly in the context of the site,
//// preventing potential execution of HTML in the site's origin. Files must be
//// saved before being opened.
////
//// See the [Microsoft docs](https://learn.microsoft.com/en-us/archive/blogs/ie/ie8-security-part-v-comprehensive-protection).

pub type DownloadOptions {
  /// Forces downloaded files to be saved before opening, preventing execution
  /// in the site's context. Plume default.
  NoOpen
}

pub fn to_string(value: DownloadOptions) -> String {
  case value {
    NoOpen -> "noopen"
  }
}
