# Ruby Toolchain

- State: deterministic first tranche implemented locally
- Toolchain source: `built-in-homebrew`

## Commands
- `export PATH="/opt/homebrew/opt/ruby/bin:$PATH"`
- `ruby --version`
- `ruby scripts/validate_contract.rb`
- `ruby -Ilib -e 'require "ruby_stakeholder"; puts RubyStakeholder::VERSION'`
- `ruby -Ilib -Itest test/test_ruby_stakeholder.rb`

## Docker baseline
- `docker build -t ruby-stakeholder .`
- `docker run --rm ruby-stakeholder --list-values`

## Notes
- Missing behavior must fail fast and be recorded in `GAPS.md`.
- Native validation is pure Ruby and does not depend on a Gemfile for this tranche.
