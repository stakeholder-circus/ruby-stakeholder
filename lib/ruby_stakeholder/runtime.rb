# frozen_string_literal: true

require 'json'

module RubyStakeholder
  module Runtime
    SessionConfig = Struct.new(
      :focus_family, :seed, :output_format, :experimental_provider, :list_values,
      keyword_init: true
    )

    module_function

    def run(config, out: $stdout, err: $stderr)
      return fail_fast_experimental(config.experimental_provider, err) if config.experimental_provider

      family = config.focus_family
      raise ArgumentError, '--focus-family is required' if family.nil? || family.to_s.empty?

      family = Catalog.normalize_family(family)
      seed = normalize_seed(config.seed)
      payload = focus_payload(family, seed, config.output_format)

      if config.output_format == :json
        out.puts(JSON.generate(payload))
      else
        text_payload(payload).each { |line| out.puts(line) }
      end

      0
    rescue ArgumentError => e
      err.puts(e.message)
      2
    end

    def list_values_json
      Catalog.list_values_json
    end

    def focus_payload(family, seed, output_format)
      descriptor = Catalog.descriptor_for(family)
      message = selected_message(descriptor, family, seed)
      {
        'contract' => 'family-focus-deterministic-v1',
        'focusFamily' => Catalog.family_label(family),
        'familyGroup' => Catalog.family_group_label(family),
        'familyTitle' => descriptor[:title],
        'seed' => seed,
        'outputFormat' => output_format.to_s,
        'message' => message,
        'generationProvenance' => {
          'sourceRepo' => 'ruby-stakeholder',
          'baseline' => 'next20-family-focus',
          'experimental' => false,
          'adapterType' => 'static-catalog',
          'promptVersion' => nil
        }
      }
    end

    def text_payload(payload)
      [
        "ruby-stakeholder family-focus session for #{payload['focusFamily']}",
        "group=#{payload['familyGroup']} seed=#{payload['seed']} output=#{payload['outputFormat']}",
        "message=#{payload['message']}"
      ]
    end

    def selected_message(descriptor, family, seed)
      variants = [descriptor[:low], descriptor[:high], descriptor[:extreme]]
      index = (seed.to_s.bytes.sum + family.to_s.bytes.sum) % variants.length
      variants[index]
    end

    def normalize_seed(seed)
      seed.nil? ? '0' : seed.to_s
    end

    def fail_fast_experimental(provider, err)
      err.puts("experimental provider mode is not enabled in ruby-stakeholder yet: #{provider}")
      2
    end
  end
end
