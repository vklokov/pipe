# frozen_string_literal: true

module Pipe
  class Person < Entity
    def inspect
      "<Pipe::Person @id=#{id} @name=#{name} @email=#{email}"
    end

    def organization
      return nil unless self.org_id

      Pipe::Organization.find(self.org_id)
    end

    class << self
      def fields
        @fields ||= fields_for(Pipe::Routes::ROUTE_PERSON_FIELDS)
      end
    end
  end
end
