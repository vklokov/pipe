# frozen_string_literal: true

module Pipe
  class Organization < Entity
    def inspect
      "<Pipe::Organization @id=#{id} @name=#{name}>"
    end

    class << self
      def fields
        @fields ||= Pipe::Field.fields(:organization)
      end
    end
  end
end
