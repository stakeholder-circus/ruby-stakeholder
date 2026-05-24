# ruby-stakeholder Status

- Role: selected next-20 local-only Ruby target
- Parity class: full-parity
- State: native-validated local deterministic tranche
- Rewrite completeness: 38%
- Functionality completeness: 31%
- Branch: `main`
- Origin: `git@github.com:stakeholder-circus/ruby-stakeholder.git`
- Upstream: `https://github.com/giacomo-b/rust-stakeholder`

## Evidence
- `PATH="/opt/homebrew/opt/ruby/bin:$PATH" python3 scripts/validate_scaffold.py`
- `PATH="/opt/homebrew/opt/ruby/bin:$PATH" ruby -c bin/ruby-stakeholder`
- `PATH="/opt/homebrew/opt/ruby/bin:$PATH" ruby scripts/validate_contract.rb`
- `PATH="/opt/homebrew/opt/ruby/bin:$PATH" ruby -Itest test/test_ruby_stakeholder.rb`
- `bin/ruby-stakeholder --list-values` with Homebrew Ruby
- same-seed deterministic JSON diff for `platform-engineering`
- explicit `--experimental-provider local-demo` fail-fast smoke

## Blockers
- Full live-provider/runtime support is deferred to the second-pass provider rollout wave.
- Publication is blocked until the publication/governance wave completes and remote access is available.
- Later families are intentionally grouped fallback work for this tranche.

## Next
- Keep deterministic baseline behavior stable.
- Expand later families only through the grouped fallback lane.
- Keep first-push traceability rows current.

## Canonical references
- `/Users/davidsupan/shareholder/stakeholder-core/docs/program/index.md`
- `/Users/davidsupan/shareholder/stakeholder-core/docs/program/next-20-wave.md`
