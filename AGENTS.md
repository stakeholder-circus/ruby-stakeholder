# ruby-stakeholder AGENTS

- Preserve imported Rust history and provenance.
- Queue state: deterministic first tranche implemented locally in the next-20 autonomous sprint.
- Origin: `git@github.com:stakeholder-circus/ruby-stakeholder.git`
- Upstream: `https://github.com/giacomo-b/rust-stakeholder`
- Deterministic normalized JSON is the baseline contract.
- Missing behavior must fail fast and be recorded in `GAPS.md`.
- No placeholder runtime behavior once implementation starts.
- Use Homebrew Ruby, not macOS `/usr/bin/ruby`.

## Planned promotion commands
- `export PATH="/opt/homebrew/opt/ruby/bin:$PATH"`
- `ruby --version`
- `ruby scripts/validate_contract.rb`
