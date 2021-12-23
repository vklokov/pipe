# frozen_string_literal: true

module Pipe
  class Field
    attr_reader :id, :options, :kind, :key, :source

    def inspect
      "<Pipe::Field @id=#{id} @kind=#{kind} @key=#{key} @options=#{options}>"
    end

    def initialize(source)
      @source  = source
      @id      = source[:id]
      @name    = source[:name]
      @options = source[:options]
      @kind    = source[:field_type]
      @key     = source[:key]
    end

    def option(id)
      @options.find { |opt| opt[:id] == id.to_i }[:label]
    rescue StandardError
      nil
    end

    def options_include_value?(value)
      @options.map { |item| item[:label] }.include? value
    end

    def enum?
      %w[enum visible_to].include? @kind
    end

    def date?
      @kind == 'date'
    end

    def money?
      @kind == 'monetary'
    end

    def user?
      @kind == 'user'
    end

    def relation?
      %w[people org user].include? @kind
    end

    class << self
      attr_reader :resource

      def fields(resource_name)
        @resource = resource_name
        fetch_fields
        # if Pipe.config.cache_enabled?
        #   fetch_cache_fields
        # else
        #   fetch_fields
        # end
      end

      private

      # def resource_cache_key
      #   [
      #     Pipe.config.cache_store_prefix,
      #     resource,
      #     'fields'
      #   ].join('-')
      # end

      # def fetch_cache_fields
      #   return cache_fields if cache_fields.positive?

      #   fresh_fields = fetch_fields
      #   Pipe.config.cache_store.set(
      #     resource_cache_key,
      #     fresh_fields.to_json,
      #     ex: Pipe.config.cache_fields_time_delta
      #   )
      #   fresh_fields
      # rescue StandardError
      #   fetch_fields
      # end

      # def cache_fields
      #   JSON.parse(
      #     Pipe.config.cache_store.get(resource_cache_key),
      #     symbolize_names: true
      #   )
      # rescue StandardError
      #   []
      # end

      def fetch_fields
        route = Object.const_get("Pipe::Routes::ROUTE_#{resource.upcase}_FIELDS")
        response = Pipe::Client.new(route).get
        response[:data].map do |field|
          new(field)
        end
      rescue StandardError
        []
      end
    end
  end
end
