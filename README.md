# plume

[![Package Version](https://img.shields.io/hexpm/v/plume)](https://hex.pm/packages/plume)
[![Downloads](https://img.shields.io/hexpm/dt/plume)](https://hex.pm/packages/plume)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/plume/)
[![Test](https://github.com/scott-ray-wilson/plume/actions/workflows/test.yml/badge.svg)](https://github.com/scott-ray-wilson/plume/actions/workflows/test.yml)
[![License](https://img.shields.io/hexpm/l/plume)](https://github.com/scott-ray-wilson/plume/blob/main/LICENSE)

Sensible HTTP security headers for Gleam web servers, inspired by
[helmet](https://helmetjs.github.io/).

Built
on [gleam_http](https://hexdocs.pm/gleam_http/), so it works with
[wisp](https://hexdocs.pm/wisp/), [mist](https://hexdocs.pm/mist/), or any
other compatible server ([examples below](#integrations)).

## Install

```sh
gleam add plume@1
```

## Usage

As `use` middleware:

```gleam
import gleam/http/response.{type Response}
import plume

pub fn handler() -> Response(String) {
  use <- plume.middleware(plume.default())
  response.new(200)
}
```

Or directly on a response:

```gleam
import gleam/http/response.{type Response}
import plume

pub fn handler() -> Response(String) {
  response.new(200) |> plume.set_headers(plume.default())
}
```

`plume.default()` ships a starter CSP, `nosniff`, `SameOrigin` frame options,
HSTS for one year including subdomains, and other widely-recommended values.
Override with record-update syntax — `Some(value)` to set the header, `None`
to leave it unset — or start from `plume.new()` to opt in header-by-header:

```gleam
import gleam/option.{None, Some}
import plume
import plume/frame_options

pub fn config() -> plume.Config {
  plume.Config(
    ..plume.default(),
    frame_options: Some(frame_options.Deny),
    referrer_policy: None,
  )
}
```

Each header lives in its own submodule (e.g. `plume/content_security_policy`,
`plume/strict_transport_security`) with typed variants for every directive.
Further documentation can be found at <https://hexdocs.pm/plume>.

## Integrations

### With Wisp

```gleam
import plume
import wisp.{type Request, type Response}

pub fn handle_request(_req: Request) -> Response {
  use <- plume.middleware(plume.default())
  wisp.ok()
}
```

### With Mist

```gleam
import gleam/bytes_tree
import gleam/erlang/process
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import mist.{type Connection, type ResponseData}
import plume

pub fn handle_request(_req: Request(Connection)) -> Response(ResponseData) {
  use <- plume.middleware(plume.default())
  response.new(200)
  |> response.set_body(mist.Bytes(bytes_tree.from_string("Hello!")))
}

pub fn main() {
  let assert Ok(_) =
    handle_request
    |> mist.new
    |> mist.port(8000)
    |> mist.start

  process.sleep_forever()
}
```

## Development

```sh
gleam build  # Compile the project
gleam test   # Run the tests
```
