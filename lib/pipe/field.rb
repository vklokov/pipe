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
      @options.find {|opt| opt[:id] == id.to_i }[:label]
    rescue
      nil
    end

    def options_include_value?(value)
      @options.map {|item| item[:label]}.include? value
    end

    def enum?
      %w(enum visible_to).include? @kind
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
      ['people', 'org', 'user'].include? @kind
    end
  end
end
