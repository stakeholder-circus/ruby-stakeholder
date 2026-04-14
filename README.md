> [!WARNING]
> This repository is AI-assisted and manually reviewed. It now carries the deterministic Ruby first-tranche implementation locally.

# ruby-stakeholder

Ruby stakeholder runtime under stakeholder-circus.

## Status
- Deterministic first tranche is implemented locally.
- Local-only scaffold remains unpublished; no upstream tracking yet.
- Default branch remains `main`; active work happens on the repo-specific baseline branch.

## Role
- Deterministic full-parity target for the next-20 wave.
- First tranche target is `classic-six + modern-core` with grouped fallback for later families.
- Full live-provider/runtime support remains a required follow-on wave.

## Planned toolchain contract
- Toolchain source: `built-in-homebrew`
- See [docs/toolchain.md](docs/toolchain.md) for exact prep commands.

## Current guardrail
- Missing behavior must fail fast and be recorded in `GAPS.md`.
- The deterministic Ruby tranche is authoritative until the follow-on wave.
- Use Homebrew Ruby, not macOS `/usr/bin/ruby`.

## Documentation
- [STATUS.md](STATUS.md)
- [PARITY.md](PARITY.md)
- [GAPS.md](GAPS.md)
- [docs/remotes.md](docs/remotes.md)
- [docs/provenance.md](docs/provenance.md)
- [docs/toolchain.md](docs/toolchain.md)
- [docs/traceability/first-push-families.md](docs/traceability/first-push-families.md)
