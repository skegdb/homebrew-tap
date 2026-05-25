# skegdb Homebrew Tap

Homebrew formulae for [skeg](https://github.com/skegdb/skeg) (RAM-frugal
vector + KV store for Personal AI inference) and its companion CLI / TUI.

## Install

```sh
brew tap skegdb/tap
brew install skeg            # server (skeg + skeg-resp3 binaries)
brew install skeg-cli        # command-line tool
brew install skeg-tui        # terminal UI (skeg-top)
```

Run as a background service:

```sh
brew services start skeg
```

Logs land in `$(brew --prefix)/var/log/skeg.{log,err.log}`.

## Available formulae

| formula | binary | what |
|---|---|---|
| `skeg` | `skeg`, `skeg-resp3` | server (binary protocol + RESP3) |
| `skeg-cli` | `skeg-cli` | offline index builder, inspector |
| `skeg-tui` | `skeg-top` | live dashboard, VINDEX browser |

## Platforms

Pre-built binaries for aarch64 only:

- macOS arm64 (M1/M2/M3)
- Linux aarch64 (cloud ARM instances, DGX Spark)

The SIMD distance kernels are NEON-only in v0.1; an AVX2 path for x86_64
is on the roadmap. Until that lands, x86_64 users build from source and
get the scalar fallback (slower than the published bench numbers). See
the upstream [skeg](https://github.com/skegdb/skeg) repo for build
instructions.

## Updating

Formulae are bumped automatically on every release by GitHub Actions in
the upstream repos. The maintainer reviews and merges the bump PRs.

## Reporting issues

Formula bugs (install failures, service config, etc.): open an issue
here. Upstream bugs (the binary itself): open on the relevant
[`skegdb`](https://github.com/skegdb) repo.

## License

Tap repo content: Apache-2.0. Each binary keeps its own license (all
Apache-2.0 at the moment).
