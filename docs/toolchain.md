  # Ruby Toolchain

  - State: scaffold-only next-20 prep
  - Toolchain source: `built-in-homebrew`

  ## Planned commands after promotion
    - `export PATH="/opt/homebrew/opt/ruby/bin:$PATH"`
- `ruby --version`
- `bundle --version`

  ## Scaffold-time checks
  - `python3 scripts/validate_scaffold.py`
  - `/nix/var/nix/profiles/default/bin/nix --extra-experimental-features 'nix-command flakes' flake lock`

  ## Current limitation
  - Use Homebrew Ruby, not macOS /usr/bin/ruby.
