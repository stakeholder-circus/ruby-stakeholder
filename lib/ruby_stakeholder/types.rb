# frozen_string_literal: true

module RubyStakeholder
  module Types
    DEVELOPMENT_TYPES = {
      'backend' => :backend,
      'frontend' => :frontend,
      'fullstack' => :fullstack,
      'data_science' => :data_science,
      'dev_ops' => :dev_ops,
      'blockchain' => :blockchain,
      'machine_learning' => :machine_learning,
      'systems_programming' => :systems_programming,
      'game_development' => :game_development,
      'security' => :security
    }.freeze

    JARGON_LEVELS = {
      'low' => :low,
      'medium' => :medium,
      'high' => :high,
      'extreme' => :extreme
    }.freeze

    COMPLEXITIES = {
      'low' => :low,
      'medium' => :medium,
      'high' => :high,
      'extreme' => :extreme
    }.freeze

    OUTPUT_FORMATS = {
      'text' => :text,
      'json' => :json
    }.freeze

    FAMILIES = {
      'code_analyzer' => :code_analyzer,
      'data_processing' => :data_processing,
      'jargon' => :jargon,
      'metrics' => :metrics,
      'network_activity' => :network_activity,
      'system_monitoring' => :system_monitoring,
      'agent_workflows' => :agent_workflows,
      'platform_engineering' => :platform_engineering,
      'observability_ai_runtime' => :observability_ai_runtime,
      'delivery_preview_ops' => :delivery_preview_ops,
      'supply_chain_security' => :supply_chain_security,
      'evaluation_and_guardrails' => :evaluation_and_guardrails,
      'knowledge_retrieval' => :knowledge_retrieval,
      'edge_client_runtime' => :edge_client_runtime,
      'identity_and_trust' => :identity_and_trust,
      'aibom_provenance' => :aibom_provenance,
      'agent_boundary_security' => :agent_boundary_security,
      'embedded_agentic_pipeline' => :embedded_agentic_pipeline,
      'data_governance_compliance' => :data_governance_compliance,
      'finops_capacity' => :finops_capacity,
      'blockchain_protocol_ops' => :blockchain_protocol_ops,
      'cross_chain_interop' => :cross_chain_interop,
      'proof_and_sequencer_ops' => :proof_and_sequencer_ops,
      'hybrid_runtime_ops' => :hybrid_runtime_ops,
      'capacity_cost_controller' => :capacity_cost_controller,
      'batch_execution_tuner' => :batch_execution_tuner,
      'compiler_maintainer' => :compiler_maintainer,
      'interop_adapter_engineer' => :interop_adapter_engineer,
      'preflight_capacity_planner' => :preflight_capacity_planner,
      'simulator_performance_engineer' => :simulator_performance_engineer,
      'fhir_profile_generator' => :fhir_profile_generator,
      'smart_launch_oauth' => :smart_launch_oauth,
      'bulk_fhir_population_ops' => :bulk_fhir_population_ops,
      'hl7v2_feed_ops' => :hl7v2_feed_ops,
      'clinical_workflow_events' => :clinical_workflow_events,
      'dicomweb_imaging_ops' => :dicomweb_imaging_ops,
      'openehr_semantic_record_ops' => :openehr_semantic_record_ops,
      'device_telemetry_clinical' => :device_telemetry_clinical,
      'emr_vendor_adapter' => :emr_vendor_adapter,
      'ocpp_chargepoint_ops' => :ocpp_chargepoint_ops,
      'ocpi_roaming_ops' => :ocpi_roaming_ops,
      'mcp_a2a_ops' => :mcp_a2a_ops,
      'streaming_bus_ops' => :streaming_bus_ops,
      'service_mesh_rpc_ops' => :service_mesh_rpc_ops
    }.freeze

    module_function

    def normalize(value, table, label)
      key = value.to_s.strip.downcase.tr('-', '_')
      table.fetch(key) { raise ArgumentError, "unknown #{label}: #{value}" }
    end

    def normalize_dev_type(value)
      normalize(value, DEVELOPMENT_TYPES, 'dev type')
    end

    def normalize_jargon_level(value)
      normalize(value, JARGON_LEVELS, 'jargon level')
    end

    def normalize_complexity(value)
      normalize(value, COMPLEXITIES, 'complexity')
    end

    def normalize_output_format(value)
      normalize(value, OUTPUT_FORMATS, 'output format')
    end

    def normalize_family(value)
      normalize(value, FAMILIES, 'family')
    end

    def complexity_count(level)
      case normalize_complexity(level)
      when :low then 1
      when :medium then 2
      when :high then 3
      when :extreme then 4
      end
    end
  end
end
