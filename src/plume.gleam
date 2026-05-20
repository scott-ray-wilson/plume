import gleam/http/response.{type Response}
import gleam/option.{type Option, None, Some}
import plume/content_type_options.{type ContentTypeOptions} as cto
import plume/cross_origin_embedder_policy.{type CrossOriginEmbedderPolicy} as coep
import plume/cross_origin_opener_policy.{type CrossOriginOpenerPolicy} as coop
import plume/cross_origin_resource_policy.{type CrossOriginResourcePolicy} as corp
import plume/origin_agent_cluster.{type OriginAgentCluster} as oac

pub opaque type Config {
  Config(
    content_type_options: Option(ContentTypeOptions),
    cross_origin_embedder_policy: Option(CrossOriginEmbedderPolicy),
    cross_origin_opener_policy: Option(CrossOriginOpenerPolicy),
    cross_origin_resource_policy: Option(CrossOriginResourcePolicy),
    origin_agent_cluster: Option(OriginAgentCluster),
  )
}

pub fn default() -> Config {
  Config(
    content_type_options: Some(cto.NoSniff),
    cross_origin_embedder_policy: None,
    cross_origin_opener_policy: Some(coop.SameOrigin),
    cross_origin_resource_policy: Some(corp.SameOrigin),
    origin_agent_cluster: Some(oac.Enabled),
  )
}

pub fn set_headers(resp: Response(body), config: Config) -> Response(body) {
  resp
  |> set_if_some(
    config.content_type_options,
    "x-content-type-options",
    cto.to_string,
  )
  |> set_if_some(
    config.cross_origin_embedder_policy,
    "cross-origin-embedder-policy",
    coep.to_string,
  )
  |> set_if_some(
    config.cross_origin_opener_policy,
    "cross-origin-opener-policy",
    coop.to_string,
  )
  |> set_if_some(
    config.cross_origin_resource_policy,
    "cross-origin-resource-policy",
    corp.to_string,
  )
  |> set_if_some(
    config.origin_agent_cluster,
    "origin-agent-cluster",
    oac.to_string,
  )
}

fn set_if_some(
  resp: Response(body),
  value: Option(value),
  name: String,
  render: fn(value) -> String,
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
