# frozen_string_literal: true

module Pipe
  class Client
    attr_reader :url, :params

    def initialize(url, params = {}, logger = Pipe::Config.logger, http_client = ::RestClient::Request)
      @url    = url
      @params = params
      @logger = logger
      @http_client = http_client
    end

    # Merge additional params
    def set(param)
      @params.merge!(param)
    end

    # Request methods
    def get
      request
    end

    def put
      request(method: :put)
    end

    def post
      request(method: :post)
    end

    def delete
      request(method: :delete)
    end

    private

    def request(method: :get)
      @logger.info("Pipe API #{method.to_s.upcase}: '#{url}', payload: #{@params}")

      response = @http_client.execute(
        method:  method,
        url:     normalize_url_with_request_method(method),
        payload: @params,
      )

      JSON.parse(response.body, symbolize_names: true)
    rescue => error
      @logger.error("Pipe API ERROR '#{error}'")
      raise error
    end

    def normalize_url_with_request_method(method)
      if method == :get
        return [base_signed_url, query_parameters].reject(&:empty?).join("&")
      end

      base_signed_url
    end

    def query_parameters
      "#{@params.each_pair.map { |k, v| "#{k}=#{v}" }.join('&')}"
    end

    def base_signed_url
      "#{base_url}?#{api_token_attribute}"
    end

    def base_url
      [api_host, url].join
    end

    def api_token_attribute
      "api_token=#{api_token}"
    end

    def api_host
      ENV['PD_API_HOST']
    end

    def api_token
      ENV['PD_API_TOKEN']
    end
  end
end
