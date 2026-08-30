FROM ruby:4.0-alpine
WORKDIR /app
COPY . .
RUN ruby scripts/validate_contract.rb && ruby -Ilib -Itest test/test_ruby_stakeholder.rb
ENTRYPOINT ["bin/ruby-stakeholder"]
