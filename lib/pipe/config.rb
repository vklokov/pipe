# frozen_string_literal: true

module Pipe
  class Config
    class << self
      attr_accessor :logger, :schema

      def logger
        @logger ||= STDOutLogger.new
      end
    end

    class STDOutLogger
      def info(message)
        puts "[#{Time.now}] Pipe: #{message}"
      end

      def error(message)
        puts "[#{Time.now}] Pipe Error: #{message}"
      end
    end
  end
end
