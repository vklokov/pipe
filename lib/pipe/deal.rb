# frozen_string_literal: true

module Pipe
  class Deal < Entity
    class << self
      def fields
        @fields ||= Pipe::Field.fields(:deal)
      end
    end

    def inspect
      "<Pipe::Deal @id=#{id} @title=#{title}>"
    end

    def organization
      return nil unless org_id

      Pipe::Organization.find(org_id)
    end

    def person
      return nil unless person_id

      Pipe::Person.find(person_id)
    end

    def files
      Pipe::File.find_all_deal_files(id)
    end
  end
end
