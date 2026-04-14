from pathlib import Path
required = [
    'README.md', 'AI_DISCLOSURE.md', 'PARITY.md', 'GAPS.md', 'AGENTS.md',
    'docs/remotes.md', 'docs/provenance.md', 'docs/toolchain.md',
    'docs/traceability/README.md', 'docs/traceability/first-push-families.md',
    'bin/ruby-stakeholder', 'lib/ruby_stakeholder.rb', 'lib/ruby_stakeholder/version.rb',
    'lib/ruby_stakeholder/types.rb', 'lib/ruby_stakeholder/catalog.rb', 'lib/ruby_stakeholder/runtime.rb',
    'lib/ruby_stakeholder/cli.rb', 'test/test_ruby_stakeholder.rb',
    '.githooks/commit-msg', '.githooks/pre-push', '.github/CODEOWNERS', '.github/PULL_REQUEST_TEMPLATE.md',
    '.github/dependabot.yml', '.github/workflows/actionlint.yml', '.github/workflows/dependency-review.yml',
    '.github/workflows/ci.yml', '.github/workflows/ci-native.yml', '.github/workflows/docker-smoke.yml',
    '.github/workflows/codeql.yml', 'Dockerfile', 'scripts/validate_contract.rb', 'flake.nix', 'flake.lock'
]
missing = [path for path in required if not Path(path).exists()]
if missing:
    raise SystemExit('missing scaffold files: ' + ', '.join(missing))
print('scaffold validated')
