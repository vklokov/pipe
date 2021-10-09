# frozen_string_literal: true

module Pipe
  class Organization < Entity
    def inspect
      "<Pipe::Organization @id=#{id} @name=#{name}>"
    end

    class << self
      def fields
        @fields ||= fields_for(Pipe::Routes::ROUTE_ORGANIZATION_FIELDS)
      end
    end
  end
end
