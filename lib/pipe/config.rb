# frozen_string_literal: true

module Pipe
  class Config
    attr_accessor :logger, :schema, :api_token, :cache_store

    CACHE_STORE_PREFIX = 'pipe-cache'
    CACHE_FIELDS_TIME_DELTA = 86_400

    def initialize
      @logger = STDOutLogger.new
    end

    def cache_enabled?
      !!cache_store
    end

    def cache_store_prefix
      CACHE_STORE_PREFIX
    end

    def cache_fields_time_delta
      CACHE_FIELDS_TIME_DELTA
    end

    # Stub logger
    class STDOutLogger
      def info(message)
        puts "[Pipe info - #{Time.now}] #{message}"
      end

      def error(message)
        puts "[Pipe Error - #{Time.now}] #{message}"
      end
    end
  end
end
