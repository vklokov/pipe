# frozen_string_literal: true

RSpec.describe Pipe do
  it 'should return version' do
    expect(Pipe::VERSION).to be_kind_of(String)
  end
end
