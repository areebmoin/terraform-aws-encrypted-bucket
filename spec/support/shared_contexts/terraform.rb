require 'aws-sdk'
require 'awspec'
require 'ostruct'

require_relative '../terraform_module'

shared_context :terraform do
  include Awspec::Helper::Finder

  let(:vars) {
    OpenStruct.new(
        TerraformModule.configuration
            .for(:harness)
            .vars)
  }

  def configuration
    TerraformModule.configuration
  end

  def output_for(role, name, opts = {})
    TerraformModule.output_for(role, name, opts)
  end

  def reprovision(overrides = nil)
    TerraformModule.provision_for(
        :harness,
        TerraformModule.configuration.for(:harness, overrides).vars)
  end

  def plan(overrides = nil)
    TerraformModule.plan_for(
        :harness,
        TerraformModule.configuration.for(:harness, overrides).vars)
  end

  def destroy(overrides = nil)
    TerraformModule.destroy_for(
        :harness,
        TerraformModule.configuration.for(:harness, overrides).vars,
        force: true)
  end
end