//// X-Content-Type-Options
////
//// This response header indicates that the [MIME types](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/MIME_types)
//// advertised in the `Content-Type` headers should be respected and not changed.
//// It is a way to opt out of [MIME type sniffing](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/MIME_types#mime_sniffing),
//// reducing exposure to drive-by download attacks and the serving of user-uploaded content
//// with an unexpected MIME type.
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Content-Type-Options).

pub type ContentTypeOptions {
  /// Blocks a request if the request destination is of type `style` and
  /// the MIME type is not `text/css`, or of type `script` and the MIME type
  /// is not a [JavaScript MIME type](https://mimesniff.spec.whatwg.org/#javascript-mime-type). Plume default.
  NoSniff
}

pub fn to_string(value: ContentTypeOptions) -> String {
  case value {
    NoSniff -> "nosniff"
  }
}
