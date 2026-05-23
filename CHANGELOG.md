# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Removed

- `plume.middleware`. Use `plume.set_headers` directly on a response instead.
  Override individual headers by piping into `response.set_header` after
  `set_headers`.

## [1.0.0] - 2026-05-23

Initial release.

### Added

- `plume.Config`, `plume.new`, and `plume.default` for building a header policy.
- `plume.middleware` and `plume.set_headers` for applying a policy to a
  `gleam_http` response.
- Typed submodules for each supported header:
  - `plume/content_security_policy`
  - `plume/content_type_options`
  - `plume/cross_origin_embedder_policy`
  - `plume/cross_origin_opener_policy`
  - `plume/cross_origin_resource_policy`
  - `plume/dns_prefetch_control`
  - `plume/download_options`
  - `plume/frame_options`
  - `plume/origin_agent_cluster`
  - `plume/permissions_policy`
  - `plume/permitted_cross_domain_policies`
  - `plume/referrer_policy`
  - `plume/strict_transport_security`
  - `plume/xss_protection`
