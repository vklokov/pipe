# frozen_string_literal: true

module Pipe
  class Deal < Entity
    def inspect
      "<Pipe::Deal @id=#{id} @title=#{title}>"
    end

    def organization
      return nil unless self.org_id

      Pipe::Organization.find(self.org_id)
    end

    def person
      return nil unless self.person_id

      Pipe::Person.find(self.person_id)
    end

    class << self
      def fields
        @fields ||= fields_for(Pipe::Routes::ROUTE_DEAL_FIELDS)
      end
    end
  end
end
