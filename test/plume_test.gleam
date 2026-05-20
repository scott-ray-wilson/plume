import gleam/http/response
import gleeunit
import plume

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn plume_default_test() {
  let config = plume.default()

  let resp = plume.set_headers(response.new(200), config)

  assert response.get_header(resp, "cross-origin-embedder-policy") == Error(Nil)
  assert response.get_header(resp, "cross-origin-opener-policy")
    == Ok("same-origin")
  assert response.get_header(resp, "cross-origin-resource-policy")
    == Ok("same-origin")
}
