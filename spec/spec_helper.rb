# frozen_string_literal: true

require 'bundler/setup'
require 'webmock/rspec'

require 'pipe'
require_relative 'fixtures/responses'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    Pipe.configure do |c|
      c.api_token = 'secret'
      c.schema = YAML.load_file(File.join('spec', 'fixtures', 'schema.yml'))['test']
    end
  end

  config.before(:each) do
    token = 'secret'
    # 1. Activity create
    stub_request(:post, "https://api.pipedrive.com/v1/activities?api_token=#{token}")
      .to_return(
        status: 200,
        body: CREATE_ACTIVITY.to_json
      )

    # 2. Fields
    # Person fields
    stub_request(:get, "https://api.pipedrive.com/v1/personFields?api_token=#{token}")
      .to_return(
        status: 200,
        body: GET_PERSON_FIELDS.to_json
      )

    # Organization fields
    stub_request(:get, "https://api.pipedrive.com/v1/organizationFields?api_token=#{token}")
      .to_return(
        status: 200,
        body: GET_ORGANIZATION_FIELDS.to_json
      )

    # 3. Persons
    # GET: 1
    stub_request(:get, "https://api.pipedrive.com/v1/persons/1?api_token=#{token}")
      .to_return(
        status: 200,
        body: GET_PERSON.to_json
      )

    # GET: 2
    stub_request(:get, "https://api.pipedrive.com/v1/persons/2?api_token=#{token}")
      .to_return(
        status: 200,
        body: GET_PERSON_WITHOUT_ORG.to_json
      )

    # POST: 1
    stub_request(:post, "https://api.pipedrive.com/v1/persons/?api_token=#{token}")
      .to_return(
        status: 200,
        body: GET_PERSON.to_json
      )

    # PUT: 1
    stub_request(:put, "https://api.pipedrive.com/v1/persons/1?api_token=#{token}")
      .to_return(
        status: 200,
        body: GET_UPDATED_PERSON.to_json
      )

    # DELETE: 1
    stub_request(:delete, "https://api.pipedrive.com/v1/persons/1?api_token=#{token}")
      .to_return(
        status: 200,
        body: GET_DELETED_PERSON.to_json
      )

    # 4. Organization
    # GET: 1
    stub_request(:get, "https://api.pipedrive.com/v1/organizations/1?api_token=#{token}")
      .to_return(
        status: 200,
        body: GET_ORGANIZATION.to_json
      )
  end
end
