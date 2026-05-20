import gleam/http/response.{type Response}
import gleam/option.{type Option, None, Some}
import plume/content_type_options.{type ContentTypeOptions} as cto
import plume/cross_origin_embedder_policy.{type CrossOriginEmbedderPolicy} as coep
import plume/cross_origin_opener_policy.{type CrossOriginOpenerPolicy} as coop
import plume/cross_origin_resource_policy.{type CrossOriginResourcePolicy} as corp
import plume/dns_prefetch_control.{type DnsPrefetchControl} as dpc
import plume/download_options.{type DownloadOptions} as do
import plume/frame_options.{type FrameOptions} as fo
import plume/origin_agent_cluster.{type OriginAgentCluster} as oac
import plume/permitted_cross_domain_policies.{
  type PermittedCrossDomainPolicies,
} as pcdp
import plume/xss_protection.{type XssProtection} as xp

pub opaque type Config {
  Config(
    content_type_options: Option(ContentTypeOptions),
    cross_origin_embedder_policy: Option(CrossOriginEmbedderPolicy),
    cross_origin_opener_policy: Option(CrossOriginOpenerPolicy),
    cross_origin_resource_policy: Option(CrossOriginResourcePolicy),
    dns_prefetch_control: Option(DnsPrefetchControl),
    download_options: Option(DownloadOptions),
    frame_options: Option(FrameOptions),
    origin_agent_cluster: Option(OriginAgentCluster),
    permitted_cross_domain_policies: Option(PermittedCrossDomainPolicies),
    xss_protection: Option(XssProtection),
  )
}

pub fn default() -> Config {
  Config(
    content_type_options: Some(cto.NoSniff),
    cross_origin_embedder_policy: None,
    cross_origin_opener_policy: Some(coop.SameOrigin),
    cross_origin_resource_policy: Some(corp.SameOrigin),
    dns_prefetch_control: Some(dpc.Off),
    download_options: Some(do.NoOpen),
    frame_options: Some(fo.SameOrigin),
    origin_agent_cluster: Some(oac.Enabled),
    permitted_cross_domain_policies: Some(pcdp.None),
    xss_protection: Some(xp.Disabled),
  )
}

pub fn set_headers(resp: Response(body), config: Config) -> Response(body) {
  resp
  |> set_header_if_some(
    config.content_type_options,
    "x-content-type-options",
    cto.to_string,
  )
  |> set_header_if_some(
    config.cross_origin_embedder_policy,
    "cross-origin-embedder-policy",
    coep.to_string,
  )
  |> set_header_if_some(
    config.cross_origin_opener_policy,
    "cross-origin-opener-policy",
    coop.to_string,
  )
  |> set_header_if_some(
    config.cross_origin_resource_policy,
    "cross-origin-resource-policy",
    corp.to_string,
  )
  |> set_header_if_some(
    config.dns_prefetch_control,
    "x-dns-prefetch-control",
    dpc.to_string,
  )
  |> set_header_if_some(
    config.download_options,
    "x-download-options",
    do.to_string,
  )
  |> set_header_if_some(config.frame_options, "x-frame-options", fo.to_string)
  |> set_header_if_some(
    config.origin_agent_cluster,
    "origin-agent-cluster",
    oac.to_string,
  )
  |> set_header_if_some(
    config.permitted_cross_domain_policies,
    "x-permitted-cross-domain-policies",
    pcdp.to_string,
  )
  |> set_header_if_some(
    config.xss_protection,
    "x-xss-protection",
    xp.to_string,
  )
}

fn set_header_if_some(
  resp: Response(body),
  value: Option(value),
  name: String,
  render: fn(value) -> String,
) -> Response(body) {
  case value {
    Some(value) -> response.set_header(resp, name, render(value))
    None -> resp
  }
}
