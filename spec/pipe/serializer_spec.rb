# frozen_string_literal: true

RSpec.describe Pipe::Serializer do

  let(:raw_resource) { GET_PERSON[:data] }

  let(:fields) do
    GET_PERSON_FIELDS[:data].map do |field|
      Pipe::Field.new(field)
    end
  end

  let(:schema) do
    Pipe::Utils.deep_symbolize_keys(
      YAML.load_file(File.join('spec', 'fixtures', 'schema.yml'))['test']
    )[:person]
  end

  context "#serialize" do

    subject { described_class.new(raw_resource, fields, schema).serialize }

    it 'should be a hash' do
      expect(subject).to be_kind_of(Hash)
    end

    it 'should have custom field' do
      expect(subject).to have_key(:custom_person_field)
    end

    it 'should transform email to string' do
      expect(subject[:email]).to_not be(nil)
      expect(subject[:email]).to be_kind_of(String)
    end

    it 'should parse :date for field :add_time' do
      expect(subject[:add_time]).to be_kind_of(DateTime)
    end
  end

  context "#deserialize" do

    let(:payload) { { custom_person_field: 'Option 2', add_time: Time.now } }
    let(:custom_field_key) { 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa22'.to_sym }
    
    subject { described_class.new(payload, fields, schema).deserialize }

    it 'should be a hash' do
      expect(subject).to be_kind_of(Hash)
    end

    it 'should convert enum value to :field_key' do
      expect(subject).to have_key(custom_field_key)
    end

    it 'should convert :date to :string' do
      expect(subject[:add_time]).to be_kind_of(String)
    end
  end

end
