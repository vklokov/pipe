# frozen_string_literal: true

RSpec.describe Pipe::Utils do
  let(:hash) do
    {
      "foo" => {
        "baz" => {
          "bar": 1
        }
      }
    }
  end

  subject { described_class.deep_symbolize_keys(hash) }

  it 'should symbolize keys in hash' do
    expect(subject.dig(:foo, :baz, :bar)).to eq(1)
  end
end
