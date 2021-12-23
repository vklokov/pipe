# frozen_string_literal: true

# RSpec.describe Pipe::Config do
#   let(:schema_yml) { YAML.load_file(File.join('spec', 'fixtures', 'schema.yml'))['test'] }

#   it 'should return STDOutLogger' do
#     expect(described_class.logger).to be_kind_of(Pipe::Config::STDOutLogger)
#   end

#   it 'should be able to set CustomLogger as logger' do
#     CustomLogger = Class.new(Pipe::Config::STDOutLogger)
#     described_class.logger = CustomLogger.new

#     expect(described_class.logger).to be_kind_of(CustomLogger)
#   end

#   it 'should be able to set fields schema' do
#     described_class.schema = schema_yml
#     expect(described_class.schema).to_not be(nil)
#   end
# end
