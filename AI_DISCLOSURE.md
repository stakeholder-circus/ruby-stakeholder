# AI Disclosure

- Repository: `ruby-stakeholder`
- Role: local-only deterministic first tranche in the next-20 autonomous sprint
- Review model: AI-assisted drafting with manual review required before publication
- Provenance model: imported Rust history retained; Ruby tranche content is derivative and traceable
- Attribution intent: preserve upstream MIT notice exactly and record later manual changes explicitly
- Contact: `@davidsupan`

## Commit trailers
- `Reviewed-by: David Supan`
- `Assisted-by: Codex`
- `Generated-by: Codex` when a commit is primarily model-drafted

## Guardrails
- No silent divergence from `stakeholder-core`
- Missing features must fail fast and be recorded in `GAPS.md`
- Deterministic normalized JSON remains the baseline target
