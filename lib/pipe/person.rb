# frozen_string_literal: true

module Pipe
  class Person < Entity
    class << self
      def fields
        @fields ||= Pipe::Field.fields(:person)
      end
    end

    def inspect
      "<Pipe::Person @id=#{id} @name=#{name} @email=#{email}>"
    end

    def organization
      return nil unless self.org_id

      Pipe::Organization.find(self.org_id)
    end
  end
end
