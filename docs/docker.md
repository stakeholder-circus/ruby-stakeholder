# Ruby Docker

## Build and test
- `docker build -t ruby-stakeholder .`
- `docker run --rm ruby-stakeholder --list-values`

## Rationale
- The image syntax-checks the Ruby baseline before packaging the runtime entrypoint.
- Docker is the reproducible Linux gate; host and CI matrices still cover native OS behavior.
