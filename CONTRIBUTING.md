# Contributing

Thanks for your interest in plume. Contributions of all sizes are welcome —
bug reports, fixes, new header support, docs, and examples.

## Before you start

For anything beyond a small fix or typo, please open an issue first to discuss
the change. This avoids duplicated effort and gives a chance to agree on the
shape of the API before code is written.

For security vulnerabilities, do **not** open a public issue. See
[SECURITY.md](SECURITY.md).

## Development

You'll need [Gleam](https://gleam.run/getting-started/installing/) (>= 1.16) and
Erlang/OTP 27+ (CI runs against 28).

```sh
gleam deps download   # Fetch dependencies
gleam test            # Run the test suite
gleam format src test # Format the code
gleam build           # Compile
```

CI runs `gleam test` and `gleam format --check src test`. Both must pass before
a PR can merge, so format locally before pushing.

## Pull requests

- Fork the repository, create a branch off `main` in your fork, and open the
  PR against `scott-ray-wilson/plume`'s `main`.
- Keep the change focused — one logical change per PR.
- Add or update tests for any behavior change.
- Add an entry to `CHANGELOG.md` under an `## [Unreleased]` section at the
  top, creating the section if one doesn't yet exist. Follow the
  [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format used by
  existing entries.
- If you're adding support for a new header, give it its own submodule under
  `src/plume/`, mirroring the structure of the existing headers.

## Commit messages

This project follows [Conventional Commits](https://www.conventionalcommits.org/).
Common prefixes used here:

- `feat:` — new functionality
- `fix:` — bug fix
- `docs:` — documentation only
- `refactor:` — code change that neither fixes a bug nor adds a feature
- `style:` — formatting/whitespace only, no code change
- `chore:` — tooling, deps, release prep
- Append `!` (e.g. `refactor!:`) for breaking changes.

## Releases

Releases are cut by the maintainer. Tagging `vX.Y.Z` triggers the release
workflow, which publishes to [Hex](https://hex.pm/packages/plume) and creates
a GitHub release from the matching `CHANGELOG.md` entry.
