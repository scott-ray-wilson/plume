import gleam/http/response
import gleeunit
import plume

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn plume_middleware_test() {
  let resp = {
    use <- plume.middleware(plume.default())
    response.new(200)
  }

  assert response.get_header(resp, "x-content-type-options") == Ok("nosniff")
  assert response.get_header(resp, "x-frame-options") == Ok("SAMEORIGIN")
}

pub fn plume_new_test() {
  let config = plume.new()

  let resp = plume.set_headers(response.new(200), config)

  assert response.get_header(resp, "content-security-policy") == Error(Nil)
  assert response.get_header(resp, "x-content-type-options") == Error(Nil)
  assert response.get_header(resp, "cross-origin-embedder-policy") == Error(Nil)
  assert response.get_header(resp, "cross-origin-opener-policy") == Error(Nil)
  assert response.get_header(resp, "cross-origin-resource-policy") == Error(Nil)
  assert response.get_header(resp, "x-dns-prefetch-control") == Error(Nil)
  assert response.get_header(resp, "x-download-options") == Error(Nil)
  assert response.get_header(resp, "x-frame-options") == Error(Nil)
  assert response.get_header(resp, "origin-agent-cluster") == Error(Nil)
  assert response.get_header(resp, "permissions-policy") == Error(Nil)
  assert response.get_header(resp, "x-permitted-cross-domain-policies")
    == Error(Nil)
  assert response.get_header(resp, "referrer-policy") == Error(Nil)
  assert response.get_header(resp, "strict-transport-security") == Error(Nil)
  assert response.get_header(resp, "x-xss-protection") == Error(Nil)
}

pub fn plume_default_test() {
  let config = plume.default()

  let resp = plume.set_headers(response.new(200), config)

  assert response.get_header(resp, "content-security-policy")
    == Ok(
      "default-src 'self'; base-uri 'self'; font-src 'self' https: data:; "
      <> "form-action 'self'; frame-ancestors 'self'; img-src 'self' data:; "
      <> "object-src 'none'; script-src 'self'; script-src-attr 'none'; "
      <> "style-src 'self' https: 'unsafe-inline'; upgrade-insecure-requests",
    )
  assert response.get_header(resp, "x-content-type-options") == Ok("nosniff")
  assert response.get_header(resp, "cross-origin-embedder-policy") == Error(Nil)
  assert response.get_header(resp, "cross-origin-opener-policy")
    == Ok("same-origin")
  assert response.get_header(resp, "cross-origin-resource-policy")
    == Ok("same-origin")
  assert response.get_header(resp, "x-dns-prefetch-control") == Ok("off")
  assert response.get_header(resp, "x-download-options") == Ok("noopen")
  assert response.get_header(resp, "x-frame-options") == Ok("SAMEORIGIN")
  assert response.get_header(resp, "origin-agent-cluster") == Ok("?1")
  assert response.get_header(resp, "permissions-policy") == Error(Nil)
  assert response.get_header(resp, "x-permitted-cross-domain-policies")
    == Ok("none")
  assert response.get_header(resp, "referrer-policy") == Ok("no-referrer")
  assert response.get_header(resp, "strict-transport-security")
    == Ok("max-age=31536000; includeSubDomains")
  assert response.get_header(resp, "x-xss-protection") == Ok("0")
}
