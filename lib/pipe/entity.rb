# frozen_string_literal: true

module Pipe
  class Entity
    def initialize(source, fields)
      @source = source
      @fields = fields

      define_attributes
    end

    def as_json
      {
        object: self.class.kind,
        source: @source,
        fields: @fields.map(&:source)
      }
    end

    def define_attributes
      serialized_keys = Serializer.new(@source, self.class.fields, self.class.schema).serialize

      serialized_keys.each_pair do |key, value|
        field = key.to_s.gsub(/[0-9]/, '')
        self.class.class_eval { attr_reader field }
        self.instance_variable_set("@#{field}", value)
      end
      self
    end

    private :define_attributes

    class << self
      def find(id)
        raise Exception::AttributeError, 'id has not presented' if id.nil?

        request  = [Object.const_get("Pipe::Routes::ROUTE_#{kind.upcase}"), id].join
        response = Pipe::Client.new(request).get
        self.new(response[:data], fields)
      end

      def find_all_by_filter(filter_id)
        raise Exception::AttributeError, 'filter_id has not presented' unless filter_id

        request  = Pipe::Client.new(
          Object.const_get("Pipe::Routes::ROUTE_#{kind.upcase}"),
          filter_id: filter_id,
          start:     0,
          limit:     500,
          sort:      'id ASC'
        )
        collection = fetch_collection(request)
      end

      def search(params)
        field_type = "#{kind}Field"
        key        = params.keys.first.to_s
        term       = params.values.first
        field_key  = schema.values.include?(key) ? schema.find { |k, v| v == key }[0] : key
        request    = Pipe::Routes::ROUTE_ITEM_SEARCH
        response   = Pipe::Client.new(request, term: term, field_key: field_key, field_type: field_type, return_item_ids: true).get
        response[:data].to_a.map do |org|
          org[:id]
        end
      end

      def create(params)
        request  = Object.const_get("Pipe::Routes::ROUTE_#{kind.upcase}")
        response = Pipe::Client.new(request, deserialize(params)).post
        self.new response[:data], fields
      end

      def update(id, params)
        raise Exception::AttributeError, 'id has not presented' if id.nil?

        request  = [Object.const_get("Pipe::Routes::ROUTE_#{kind.upcase}"), id].join
        response = Pipe::Client.new(request, deserialize(params)).put
        self.new response[:data], fields
      end

      def delete(id)
        raise Exception::AttributeError, 'id has not presented' if id.nil?

        request  = [Object.const_get("Pipe::Routes::ROUTE_#{kind.upcase}"), id].join
        Pipe::Client.new(request).delete
      end

      def kind
        self.name.split('::').last.downcase.to_sym
      end

      def fetch_collection(request, collection = [])
        return collection unless request.params[:start]

        response = request.get
        response[:data].to_a.map do |source|
          collection << self.new(source, fields)
        end

        more_items_exist = response.dig(:additional_data, :pagination, :more_items_in_collection)
        next_start       = response.dig(:additional_data, :pagination, :next_start)

        if more_items_exist
          request.set(start: next_start)
          return fetch_collection(request, collection)
        end

        collection
      end

      def deserialize(params)
        Serializer.new(params, fields, schema).deserialize
      end

      def schema
        Pipe::Utils.deep_symbolize_keys(Pipe::Config.schema)[kind]
      end

      def filters
        Pipe::Utils.deep_symbolize_keys(Pipe::Config.schema)[:filters]
      end
    end
  end
end
