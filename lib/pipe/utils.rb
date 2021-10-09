# frozen_string_literal: true

module Pipe
  class Utils
    class << self
      def deep_symbolize_keys(hash)
        {}.tap do |attr|
          hash.each_pair do |k, v|
            attr[k.to_sym] = v.is_a?(Hash) ? deep_symbolize_keys(v) : v
          end
        end
      end
    end
  end
end
