# frozen_string_literal: true

RSpec.describe Pipe::Client do
  let(:persons_route) { Pipe::Routes::ROUTE_PERSON }
  let(:url) { [persons_route, 1].join }
  let(:payload) { { foo: :bar } }

  context "#new" do
    subject { described_class.new(url, payload) }

    it 'should return client url' do
      expect(subject.url).to eq(url)
    end

    it 'should return client props' do
      expect(subject.params).to have_key(:foo)
    end
  end

  context "#set" do
    subject { described_class.new(url, payload) }

    it 'should be able to set additional params' do
      subject.set(field: :baz)

      expect(subject.params).to have_key(:field)
    end
  end

  context "#get" do
    it 'should make request' do
      client = described_class.new(url)
      signed_url = client.send(:normalize_url_with_request_method, :get)

      expect(::RestClient::Request).to receive(:execute).with(
        method: :get,
        url: signed_url,
        payload: {},
      ).and_return(OpenStruct.new(body: GET_PERSON.to_json))

      client.get
    end
  end

  context "#post" do
    it 'should make request' do
      client = described_class.new(persons_route, payload)
      signed_url = client.send(:normalize_url_with_request_method, :post)

      expect(::RestClient::Request).to receive(:execute).with(
        method: :post,
        url: signed_url,
        payload: payload,
      ).and_return(OpenStruct.new(body: GET_PERSON.to_json))

      client.post
    end
  end

  context "#put" do
    it 'should make request' do
      client = described_class.new(url, payload)
      signed_url = client.send(:normalize_url_with_request_method, :put)

      expect(::RestClient::Request).to receive(:execute).with(
        method: :put,
        url: signed_url,
        payload: payload,
      ).and_return(OpenStruct.new(body: GET_PERSON.to_json))

      client.put
    end
  end

  context "#delete" do
    it 'should make request' do
      client = described_class.new(url)
      signed_url = client.send(:normalize_url_with_request_method, :delete)

      expect(::RestClient::Request).to receive(:execute).with(
        method: :delete,
        url: signed_url,
        payload: {},
      ).and_return(OpenStruct.new(body: GET_PERSON.to_json))

      client.delete
    end
  end

  context "#private" do

    let(:client) { described_class.new(url, payload) }
    let(:foobar) { "foo=bar" }

    context "#normalize_url_with_request_method" do

      it 'should return full api url for GET request' do
        expect(client.send(:normalize_url_with_request_method, :get)).to include(foobar)
      end

      it 'should return full api url for not GET request' do
        expect(client.send(:normalize_url_with_request_method, :post)).to_not include(foobar)
      end
    end

    context "#query_parameters" do
      it 'should return query parameters' do
        expect(client.send(:query_parameters)).to include(foobar)
      end
    end

    context "#base_url" do
      it 'should return base url' do
        base_url = [ENV['PD_API_HOST'], url].join

        expect(client.send(:base_url)).to eq(base_url)
      end
    end

    context "#base_signed_url" do
      it 'should return base url with token attribute' do
        signed_url = [ENV['PD_API_HOST'], url, "?api_token=#{ENV['PD_API_TOKEN']}"].join

        expect(client.send(:base_signed_url)).to eq(signed_url)
      end
    end

    context "#api_token_attribute" do
      it 'should return api_token attribute' do
        expect(client.send(:api_token_attribute)).to eq("api_token=#{ENV['PD_API_TOKEN']}")
      end
    end
  end
end
