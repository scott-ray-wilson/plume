import gleam/http/response.{type Response}
import gleam/option.{type Option, None, Some}
import plume/cross_origin_resource_policy.{type CrossOriginResourcePolicy} as corp

pub opaque type Config {
  Config(cross_origin_resource_policy: Option(CrossOriginResourcePolicy))
}

pub fn default() -> Config {
  Config(cross_origin_resource_policy: Some(corp.SameOrigin))
}

pub fn set_headers(resp: Response(body), config: Config) -> Response(body) {
  resp
  |> set_if_some(
    config.cross_origin_resource_policy,
    "cross-origin-resource-policy",
    corp.to_string,
  )
}

fn set_if_some(
  resp: Response(body),
  value: Option(policy),
  name: String,
  render: fn(policy) -> String,
) -> Response(body) {
  case value {
    Some(v) ->
      case render(v) {
        "" -> resp
        rendered -> response.set_header(resp, name, rendered)
      }
    None -> resp
  }
}
