FROM alpine:3.20
LABEL org.opencontainers.image.title="ruby-stakeholder"
LABEL org.opencontainers.image.description="Scaffold-only placeholder container for ruby-stakeholder"
CMD ["sh", "-lc", "echo 'ruby-stakeholder scaffold-only baseline';"]
