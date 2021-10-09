# frozen_string_literal: true

module Pipe
  class Serializer
    def initialize(params, fields, schema)
      @params = params
      @fields = fields
      @schema = schema
    end

    def serialize
      {}.tap do |attr|
        @params.each_pair do |key, value|
          name, value = serialize_field(key, value)
          next unless name
          attr[name.to_sym] = value
        end
      end
    end

    def deserialize
      {}.tap do |attr|
        @params.each_pair do |key, value|
          name, value = deserialize_field(key, value)
          next unless name
          attr[name.to_sym] = value
        end
      end
    end

    private

    def serialize_field(key, value)
      name  = @schema[key.to_sym] || key
      field = find_field_by_key(key)

      return [name, value] unless field

      case
      when field.enum?
        return [name, field.option(value)]
      when field.money?
        return [name, value ? value.to_f: nil]
      when field.date?
        return [name, value ? DateTime.parse(value) : nil]
      when field.relation?
        return [name, relation_field_value(value)]
      else
        [name, regular_field_value(value)]
      end
    end

    def deserialize_field(key, val)
      name  = key
      value = val

      if @schema.values.include?(key.to_s)
        row  = @schema.find { |_, v| v == key.to_s }
        name = row[0]
      end
      
      field = find_field_by_key(name)

      return [name, value] unless field

      case
      when field.money?
        return [name, value.to_f]
      when field.date?
        return [name, value] if value.is_a? String
        return [name, value.strftime('%Y-%m-%d')] if value.is_a?(Date) || value.is_a?(DateTime) || value.is_a?(Time)
        return [name, nil]
      when field.enum?
        return [nil, nil] unless field.options_include_value?(value)

        [name, (field.options.find { |opt| opt[:label] == value } || {})[:id]]
      else
        [name, value]
      end
    end

    def find_field_by_key(key)
      @fields.find { |field| field.key == key.to_s }
    end

    def relation_field_value(value)
      case value
      when Integer
        value > 0 ? value : nil
      when Hash
        value.dig(:value)
      else
        nil
      end
    end

    def regular_field_value(value)
      case value
      when String, Integer, NilClass
        return value
      when Array
        regular_field_value(value[0])
      when Hash
        value.dig(:value)
      end
    end
  end
end
