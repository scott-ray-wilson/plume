//// Sensible HTTP security headers for Gleam web servers, inspired by
//// [Helmet](https://helmetjs.github.io/).
////
//// Build a `Config` describing which headers to set on outgoing responses,
//// then apply it. `default` ships a reasonable starter policy; `new`
//// starts with no headers set.
////
//// As `use` middleware:
////
//// ```gleam
//// use <- plume.middleware(plume.default())
//// response.new(200)
//// ```
////
//// Or directly on a response:
////
//// ```gleam
//// response.new(200)
//// |> plume.set_headers(plume.default())
//// ```

import gleam/http/response.{type Response}
import gleam/option.{type Option, None, Some}
import plume/content_security_policy.{type ContentSecurityPolicy} as csp
import plume/content_type_options.{type ContentTypeOptions} as cto
import plume/cross_origin_embedder_policy.{type CrossOriginEmbedderPolicy} as coep
import plume/cross_origin_opener_policy.{type CrossOriginOpenerPolicy} as coop
import plume/cross_origin_resource_policy.{type CrossOriginResourcePolicy} as corp
import plume/dns_prefetch_control.{type DnsPrefetchControl} as dpc
import plume/download_options.{type DownloadOptions} as do
import plume/frame_options.{type FrameOptions} as fo
import plume/origin_agent_cluster.{type OriginAgentCluster} as oac
import plume/permissions_policy.{type PermissionsPolicy} as pp
import plume/permitted_cross_domain_policies.{type PermittedCrossDomainPolicies} as pcdp
import plume/referrer_policy.{type ReferrerPolicy} as rp
import plume/strict_transport_security.{type StrictTransportSecurity} as sts
import plume/xss_protection.{type XssProtection} as xp

/// Which security headers Plume should set on a response. Each field is
/// optional — `None` leaves the corresponding header untouched.
///
pub type Config {
  Config(
    content_security_policy: Option(ContentSecurityPolicy),
    content_type_options: Option(ContentTypeOptions),
    cross_origin_embedder_policy: Option(CrossOriginEmbedderPolicy),
    cross_origin_opener_policy: Option(CrossOriginOpenerPolicy),
    cross_origin_resource_policy: Option(CrossOriginResourcePolicy),
    dns_prefetch_control: Option(DnsPrefetchControl),
    download_options: Option(DownloadOptions),
    frame_options: Option(FrameOptions),
    origin_agent_cluster: Option(OriginAgentCluster),
    permissions_policy: Option(PermissionsPolicy),
    permitted_cross_domain_policies: Option(PermittedCrossDomainPolicies),
    referrer_policy: Option(ReferrerPolicy),
    strict_transport_security: Option(StrictTransportSecurity),
    xss_protection: Option(XssProtection),
  )
}

/// A `Config` with no headers configured. Use this when you want to opt in
/// to each header individually rather than starting from `default`.
///
pub fn new() -> Config {
  Config(
    content_security_policy: None,
    content_type_options: None,
    cross_origin_embedder_policy: None,
    cross_origin_opener_policy: None,
    cross_origin_resource_policy: None,
    dns_prefetch_control: None,
    download_options: None,
    frame_options: None,
    origin_agent_cluster: None,
    permissions_policy: None,
    permitted_cross_domain_policies: None,
    referrer_policy: None,
    strict_transport_security: None,
    xss_protection: None,
  )
}

/// A `Config` with sensible defaults: a starter CSP, `nosniff`,
/// `SameOrigin` frame options, HSTS for one year on the host and its
/// subdomains, and other widely-recommended values.
///
/// ## Examples
///
/// Override individual fields with record update syntax:
///
/// ```gleam
/// Config(..default(), frame_options: Some(frame_options.Deny))
/// ```
///
pub fn default() -> Config {
  Config(
    content_security_policy: Some(
      csp.Policy([
        csp.DefaultSrc([csp.Self]),
        csp.BaseUri([csp.Self]),
        csp.FontSrc([csp.Self, csp.Scheme("https"), csp.Scheme("data")]),
        csp.FormAction([csp.Self]),
        csp.FrameAncestors([csp.Self]),
        csp.ImgSrc([csp.Self, csp.Scheme("data")]),
        csp.ObjectSrc([csp.None]),
        csp.ScriptSrc([csp.Self]),
        csp.ScriptSrcAttr([csp.None]),
        csp.StyleSrc([csp.Self, csp.Scheme("https"), csp.UnsafeInline]),
        csp.UpgradeInsecureRequests,
      ]),
    ),
    content_type_options: Some(cto.NoSniff),
    cross_origin_embedder_policy: None,
    cross_origin_opener_policy: Some(coop.SameOrigin),
    cross_origin_resource_policy: Some(corp.SameOrigin),
    dns_prefetch_control: Some(dpc.Off),
    download_options: Some(do.NoOpen),
    frame_options: Some(fo.SameOrigin),
    origin_agent_cluster: Some(oac.Enabled),
    permissions_policy: None,
    permitted_cross_domain_policies: Some(pcdp.None),
    referrer_policy: Some(rp.NoReferrer),
    strict_transport_security: Some(sts.IncludeSubDomains(31_536_000)),
    xss_protection: Some(xp.Disabled),
  )
}

/// Run `handler` and set the headers from `config` on the resulting response.
///
pub fn middleware(
  config: Config,
  handler: fn() -> Response(body),
) -> Response(body) {
  handler() |> set_headers(config)
}

/// Set the headers from `config` on an existing response.
///
pub fn set_headers(resp: Response(body), config: Config) -> Response(body) {
  resp
  |> set_header_if_some(
    config.content_security_policy,
    "content-security-policy",
    csp.to_string,
  )
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
    config.permissions_policy,
    "permissions-policy",
    pp.to_string,
  )
  |> set_header_if_some(
    config.permitted_cross_domain_policies,
    "x-permitted-cross-domain-policies",
    pcdp.to_string,
  )
  |> set_header_if_some(config.referrer_policy, "referrer-policy", rp.to_string)
  |> set_header_if_some(
    config.strict_transport_security,
    "strict-transport-security",
    sts.to_string,
  )
  |> set_header_if_some(config.xss_protection, "x-xss-protection", xp.to_string)
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
