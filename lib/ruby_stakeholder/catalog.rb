# frozen_string_literal: true

require 'json'

module RubyStakeholder
  module Catalog
    FAMILY_ORDER = %i[
      code_analyzer data_processing jargon metrics network_activity system_monitoring
      agent_workflows ai_inference_ops platform_engineering observability_ai_runtime delivery_preview_ops supply_chain_security
      evaluation_and_guardrails knowledge_retrieval edge_client_runtime identity_and_trust aibom_provenance agent_boundary_security embedded_agentic_pipeline data_governance_compliance finops_capacity blockchain_protocol_ops cross_chain_interop proof_and_sequencer_ops hybrid_runtime_ops capacity_cost_controller batch_execution_tuner compiler_maintainer interop_adapter_engineer preflight_capacity_planner simulator_performance_engineer fhir_profile_generator smart_launch_oauth bulk_fhir_population_ops hl7v2_feed_ops clinical_workflow_events dicomweb_imaging_ops openehr_semantic_record_ops device_telemetry_clinical emr_vendor_adapter ocpp_chargepoint_ops ocpi_roaming_ops mcp_a2a_ops streaming_bus_ops service_mesh_rpc_ops
    ].freeze

    CLASSIC_SIX = %i[
      code_analyzer data_processing jargon metrics network_activity system_monitoring
    ].freeze

    MODERN_CORE = %i[
      agent_workflows platform_engineering observability_ai_runtime delivery_preview_ops supply_chain_security
    ].freeze

    DEDICATED_FAMILIES = (CLASSIC_SIX + MODERN_CORE).freeze
    FALLBACK_FAMILIES = (FAMILY_ORDER - DEDICATED_FAMILIES).freeze

    FAMILY_GROUP_LABELS = {
      classic_six: 'classic-six',
      modern_core: 'modern-core',
      grouped_fallback: 'grouped-fallback'
    }.freeze

    CLASSIC_FAMILIES = DEDICATED_FAMILIES.first(6).freeze
    MODERN_CORE_FAMILIES = DEDICATED_FAMILIES.drop(6).freeze

    DETAILED_DESCRIPTORS = {
      code_analyzer: {
        title: 'Code analyzer',
        protocol: nil,
        schema: nil,
        low: 'reviewing typed interfaces and SDK drift across the active service graph',
        high: 'triaging monorepo dependency edges, generated patches, and schema compatibility before merge',
        extreme: 'replaying agent-authored patchsets against contract drift, ownership boundaries, and MCP tool assumptions'
      },
      data_processing: {
        title: 'Data processing',
        protocol: nil,
        schema: nil,
        low: 'refreshing embedding corpora, batch transforms, and event windows for the current dataset',
        high: 'rebuilding hybrid retrieval indexes, semantic chunks, and NDJSON backfills for downstream consumers',
        extreme: 'reconciling multimodal pipelines, lakehouse batch cuts, and evaluation-ready data slices under deterministic ordering'
      },
      jargon: {
        title: 'Jargon refresh',
        protocol: nil,
        schema: nil,
        low: 'keeping technical language current without drifting into fake-deep jargon',
        high: 'switching phrasing toward credible 2026 agent, platform, protocol, and security terminology',
        extreme: 'enforcing modern domain vocabulary so advanced output stays precise instead of sounding synthetic'
      },
      metrics: {
        title: 'Metrics',
        protocol: nil,
        schema: nil,
        low: 'tracking queue depth, latency bands, and cost signals across the active workload',
        high: 'correlating token spend, SLO burn, GPU occupancy, and attestation coverage in one metrics lane',
        extreme: 'folding evaluation score movement, blob economics, and runner pressure into a single operations dashboard'
      },
      network_activity: {
        title: 'Network activity',
        protocol: :grpc,
        schema: nil,
        low: 'observing RPC, event-stream, and adapter traffic across the current service boundary',
        high: 'mapping MCP calls, inference APIs, registry fetches, and cross-domain message flow under backpressure',
        extreme: 'profiling mixed gRPC, Kafka, MQTT, and bridge traffic while preserving replay semantics and retry windows'
      },
      system_monitoring: {
        title: 'System monitoring',
        protocol: nil,
        schema: nil,
        low: 'watching collector pressure, runner health, and process saturation on the active stack',
        high: 'capturing GPU memory pressure, secret-scan spikes, sandbox failures, and scheduler queue churn',
        extreme: 'stitching host telemetry, proof queues, provisioning lag, and policy denials into one operational heartbeat'
      },
      agent_workflows: {
        title: 'Agent workflows',
        protocol: :mcp,
        schema: { 'name' => 'agent-workflow-envelope', 'version' => '2026-04' },
        low: 'routing coding-agent work through review queues and approval gates',
        high: 'coordinating delegated patch runs, blocked tool calls, and human checkpoints across multiple repos',
        extreme: 'orchestrating branch handoff envelopes, MCP leases, and merge-safe approval chains for background agents'
      },
      platform_engineering: {
        title: 'Platform engineering',
        protocol: nil,
        schema: nil,
        low: 'maintaining golden paths, service templates, and workload identity for self-service delivery',
        high: 'resolving platform policy denials, tenant quotas, and template drift inside the internal developer portal',
        extreme: 'reconciling workload identity, cluster tenancy, policy bundles, and queue fairness across platform control planes'
      },
      observability_ai_runtime: {
        title: 'Observability AI runtime',
        protocol: nil,
        schema: { 'name' => 'otel-runtime-event', 'version' => '2026-04' },
        low: 'recording traces, token spend, and latency bands for the active runtime',
        high: 'tracking OTel collector saturation, span cardinality, and GPU telemetry alongside tool-call traces',
        extreme: 'driving burn-rate analysis across inference queues, cost attribution, and distributed reasoning spans'
      },
      delivery_preview_ops: {
        title: 'Delivery preview ops',
        protocol: nil,
        schema: nil,
        low: 'managing preview environments, feature flags, and canary promotions for current changes',
        high: 'holding rollout gates on runner saturation, preview drift, and canary health regression signals',
        extreme: 'sequencing flag freezes, rollback windows, and staged promotion rules across agent-authored delivery pipelines'
      },
      supply_chain_security: {
        title: 'Supply-chain security',
        protocol: nil,
        schema: { 'name' => 'provenance-check', 'version' => '2026-04' },
        low: 'checking artifact trust, secret exposure, and dependency health before release',
        high: 'verifying provenance attestations, AIBOM coverage, revocation posture, and tamper signals across build lanes',
        extreme: 'gating release promotion on signed artifacts, dependency substitution checks, and cross-tool trust evidence'
      }
    }.freeze

    FAMILY_MAP = FAMILY_ORDER.each_with_object({}) do |family, memo|
      memo[family.to_s] = family
    end.freeze

    FALLBACK_PROTOCOLS = {
      ai_inference_ops: :responses_api,
      evaluation_and_guardrails: :responses_api,
      knowledge_retrieval: :responses_api,
      edge_client_runtime: :web_transport,
      agent_boundary_security: :mcp,
      blockchain_protocol_ops: :grpc,
      cross_chain_interop: :grpc,
      proof_and_sequencer_ops: :grpc,
      hybrid_runtime_ops: :grpc,
      capacity_cost_controller: :grpc,
      batch_execution_tuner: :grpc,
      compiler_maintainer: :grpc,
      interop_adapter_engineer: :grpc,
      preflight_capacity_planner: :grpc,
      simulator_performance_engineer: :grpc,
      smart_launch_oauth: :fhir_r4,
      bulk_fhir_population_ops: :bulk_fhir,
      hl7v2_feed_ops: :hl7v2,
      clinical_workflow_events: :fhir_r4,
      dicomweb_imaging_ops: :dicomweb,
      openehr_semantic_record_ops: :open_ehr,
      device_telemetry_clinical: :ihe_device,
      emr_vendor_adapter: :epic_fhir,
      ocpp_chargepoint_ops: :ocpp_21,
      ocpi_roaming_ops: :ocpi_2x,
      mcp_a2a_ops: :mcp,
      streaming_bus_ops: :kafka,
      service_mesh_rpc_ops: :grpc
    }.freeze

    module_function

    def family_label(family)
      family.to_s.tr('_', '-')
    end

    def family_group_for(family)
      return :classic_six if CLASSIC_SIX.include?(family)
      return :modern_core if MODERN_CORE.include?(family)

      :grouped_fallback
    end

    def family_group_label(family)
      FAMILY_GROUP_LABELS.fetch(family_group_for(family))
    end

    def humanize_family(family)
      family.to_s.split('_').map { |part| part == 'ai' ? 'AI' : part.capitalize }.join(' ')
    end

    def title_for_family(family)
      descriptor_for(family)[:title]
    end

    def protocol_for_family(family)
      descriptor_for(family)[:protocol]
    end

    def schema_ref_for_family(family)
      descriptor_for(family)[:schema]
    end

    def normalize_family(value)
      key = value.to_s.strip.downcase.tr('-', '_')
      FAMILY_MAP.fetch(key) { raise ArgumentError, "unknown family: #{value}" }
    end

    def descriptor_for(family)
      DETAILED_DESCRIPTORS.fetch(family) do
        label = family_label(family)
        {
          title: humanize_family(family),
          protocol: FALLBACK_PROTOCOLS[family],
          schema: nil,
          low: "grouped fallback handling for #{label}",
          high: "grouped fallback stabilizing #{label} inside the post-modern-core lane",
          extreme: "grouped fallback preserving deterministic JSON, traceability, and fail-fast gaps for #{label}"
        }
      end
    end

    def list_values_json
      {
        'outputFormats' => %w[text json],
        'flags' => %w[list-values focus-family output-format seed experimental-provider],
        'familyOrder' => FAMILY_ORDER.map { |family| family_label(family) },
        'classicSix' => CLASSIC_SIX.map { |family| family_label(family) },
        'modernCore' => MODERN_CORE.map { |family| family_label(family) },
        'dedicatedFamilies' => DEDICATED_FAMILIES.map { |family| family_label(family) },
        'fallbackFamilies' => FALLBACK_FAMILIES.map { |family| family_label(family) },
        'familyGroups' => {
          'classicSix' => CLASSIC_SIX.map { |family| family_label(family) },
          'modernCore' => MODERN_CORE.map { |family| family_label(family) },
          'groupedFallback' => FALLBACK_FAMILIES.map { |family| family_label(family) }
        },
        'implementationMode' => 'family-focus-deterministic'
      }
    end

    def security_related?(family)
      %i[supply_chain_security agent_boundary_security identity_and_trust aibom_provenance data_governance_compliance mcp_a2a_ops blockchain_protocol_ops cross_chain_interop proof_and_sequencer_ops].include?(family)
    end

    def blockchain_family?(family)
      %i[blockchain_protocol_ops cross_chain_interop proof_and_sequencer_ops].include?(family)
    end

    def quantum_family?(family)
      %i[hybrid_runtime_ops capacity_cost_controller batch_execution_tuner compiler_maintainer interop_adapter_engineer preflight_capacity_planner simulator_performance_engineer].include?(family)
    end

    def health_family?(family)
      %i[fhir_profile_generator smart_launch_oauth bulk_fhir_population_ops hl7v2_feed_ops clinical_workflow_events dicomweb_imaging_ops openehr_semantic_record_ops device_telemetry_clinical emr_vendor_adapter].include?(family)
    end

    def protocol_family?(family)
      %i[ocpp_chargepoint_ops ocpi_roaming_ops mcp_a2a_ops streaming_bus_ops service_mesh_rpc_ops network_activity].include?(family)
    end
  end
end
