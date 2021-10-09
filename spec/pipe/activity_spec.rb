# frozen_string_literal: true

RSpec.describe Pipe::Activity do
  it 'should create new activity' do
    result = described_class.create(note: 'test', subject: 'test', org_id: 1000)

    expect(result).to have_key(:success)
    expect(result).to have_key(:data)
  end
end
