# frozen_string_literal: true

require 'optparse'
require 'json'

module RubyStakeholder
  module CLI
    module_function

    def run(argv, out: $stdout, err: $stderr)
      options = default_options
      parser = option_parser(options)
      parser.parse!(argv)

      if options[:list_values]
        out.puts(JSON.pretty_generate(Runtime.list_values_json))
        return 0
      end

      config = Runtime::SessionConfig.new(**options)
      Runtime.run(config, out: out, err: err)
    rescue OptionParser::ParseError, ArgumentError => e
      err.puts(e.message)
      2
    end

    def default_options
      {
        focus_family: nil,
        seed: nil,
        output_format: :text,
        experimental_provider: nil,
        list_values: false
      }
    end

    def option_parser(options)
      OptionParser.new do |opts|
        opts.banner = 'Usage: ruby-stakeholder [options]'
        opts.on('--focus-family FAMILY', 'Focus a specific family from the canonical contract') { |value| options[:focus_family] = Types.normalize_family(value) }
        opts.on('--seed SEED', 'Deterministic seed value') { |value| options[:seed] = value }
        opts.on('--output-format FORMAT', 'Output format (text or json)') { |value| options[:output_format] = Types.normalize_output_format(value) }
        opts.on('--list-values', 'Print generator family metadata as JSON, then exit') { options[:list_values] = true }
        opts.on('--experimental-provider NAME', 'Fail fast on explicit experimental provider attempts') { |value| options[:experimental_provider] = value }
      end
    end
  end
end
