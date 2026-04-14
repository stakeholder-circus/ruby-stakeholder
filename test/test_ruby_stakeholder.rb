# frozen_string_literal: true

require 'json'
require 'stringio'
require 'minitest/autorun'
require_relative '../lib/ruby_stakeholder'

class RubyStakeholderTest < Minitest::Test
  def test_list_values_exposes_first_tranche_and_full_family_catalog
    payload = RubyStakeholder::Runtime.list_values_json

    assert_includes(payload['flags'], 'experimental-provider')
    assert_includes(payload['flags'], 'focus-family')
    assert_equal(45, payload['familyOrder'].length)
    assert_equal(
      %w[code-analyzer data-processing jargon metrics network-activity system-monitoring agent-workflows platform-engineering observability-ai-runtime delivery-preview-ops supply-chain-security],
      payload['dedicatedFamilies']
    )
  end

  def test_same_seed_json_is_deterministic
    args = %w[--focus-family platform_engineering --seed 41 --output-format json]

    out_a = StringIO.new
    err_a = StringIO.new
    out_b = StringIO.new
    err_b = StringIO.new

    code_a = RubyStakeholder::CLI.run(args.dup, out: out_a, err: err_a)
    code_b = RubyStakeholder::CLI.run(args.dup, out: out_b, err: err_b)

    assert_equal(0, code_a)
    assert_equal(0, code_b)
    assert_equal(out_a.string, out_b.string)
    assert_equal('', err_a.string)
    assert_equal('', err_b.string)
  end

  def test_focus_family_is_required
    out = StringIO.new
    err = StringIO.new

    code = RubyStakeholder::CLI.run(%w[--output-format json], out: out, err: err)

    assert_equal(2, code)
    assert_match(/focus-family is required/i, err.string)
  end

  def test_experimental_provider_fails_fast
    out = StringIO.new
    err = StringIO.new

    code = RubyStakeholder::CLI.run(%w[--experimental-provider openai-compatible], out: out, err: err)

    assert_equal(2, code)
    assert_equal('', out.string)
    assert_match(/experimental provider mode is not enabled/i, err.string)
  end
end
