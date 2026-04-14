#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'open3'

root = File.expand_path('..', __dir__)
rb_files = Dir[File.join(root, 'bin/ruby-stakeholder'), File.join(root, 'lib/**/*.rb')].sort

rb_files.each do |file|
  ok = system('ruby', '-c', file, exception: false)
  abort("syntax failed: #{file}") unless ok
end

list_out, list_err, status = Open3.capture3(File.join(root, 'bin/ruby-stakeholder'), '--list-values')
abort("list-values failed: #{list_err}") unless status.success?
payload = JSON.parse(list_out)
abort('unexpected family catalog length') unless payload['familyOrder'].length == 45
abort('missing experimental-provider flag') unless payload['flags'].include?('experimental-provider')
abort('missing focus-family flag') unless payload['flags'].include?('focus-family')

json_args = [
  '--focus-family', 'platform_engineering',
  '--seed', '41',
  '--output-format', 'json'
]
json_a, json_err_a, status_a = Open3.capture3(File.join(root, 'bin/ruby-stakeholder'), *json_args)
json_b, json_err_b, status_b = Open3.capture3(File.join(root, 'bin/ruby-stakeholder'), *json_args)
abort("deterministic json run failed: #{json_err_a} #{json_err_b}") unless status_a.success? && status_b.success?
abort('same-seed json differed') unless json_a == json_b

_, exp_err, exp_status = Open3.capture3(File.join(root, 'bin/ruby-stakeholder'), '--experimental-provider', 'openai-compatible')
abort('experimental provider did not fail fast') unless exp_status.exitstatus == 2 && exp_err.match?(/experimental provider mode is not enabled/i)

puts 'ruby contract validated'
